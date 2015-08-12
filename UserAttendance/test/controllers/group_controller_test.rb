require 'test_helper'

class GroupControllerTest < ActionController::TestCase
	context "Group Creation" do 
		should "create group" do 
			user = User.create(:name => "user1")
			hash = {:name => "group1", :lattitude => "12", :longitude => "12"}
			post :create, {:format => :json, :group => hash, :user_name => user.name}
			assert_equal 1, user.groups.size
			assert_equal "Leader", user.memberships.first.role
			assert_equal "12", user.groups.first.lattitude
		end
	end

	context "Group Data" do 
		setup do
		 	@user = User.create(:name => "abc", :password => "abc")
			@group = Group.create(:name => "group1")
			@user.memberships.create(:user => @user, :group => @group)
			@user.save!
		end

		should "return users for group" do 
			get :users, {:format => :json, :name => "group1"}
			resp = JSON.parse(response.body)["users"]
			assert_equal 1, resp.size
		end

		should "add user to group" do 
			user2 = User.create(:name => "abcd", :password => "abc")
			post :add_user, {:format => :json, :group_name => @group.name, :user_name => user2.name, :role => "student"}
			resp = JSON.parse(response.body)
			assert_equal 201, resp["status"]
			@group.reload
			assert_equal 2, @group.users.size
			assert_equal "student", user2.memberships.last.role
		end

		should "not add user to subscribed group" do 
			post :add_user, {:format => :json, :group_name => @group.name, :user_name => @user.name, :role => "student"}
			resp = JSON.parse(response.body)
			assert_equal 422, resp["status"]
		end

		should "remove user from group" do 
			post :remove_user, {:format => :json, :group_name => @group.name, :user_name => @user.name}
			resp = JSON.parse(response.body)
			assert_equal 0, @group.users.size

		end
	end
end