require 'test_helper'

class UserControllerTest < ActionController::TestCase

  context "User Creation" do 
  	should "create a user" do 
  		hash = {:name => "abc", :password => "abc"}
  		post :create, {:user => hash, :format => :json}
  		resp = JSON.parse(response.body)
  		assert_equal 1, User.count
  	end
  end

  context "Location Logging" do 
    setup do 
      @user = User.create(:name => "user1")
    end

    should "log location" do 
      hash = {:lattitude => "12", :longitude => "12"}
      post :log_location, {:format => :json, :user_name => @user.name, :location_log => hash}
      assert_equal 1, @user.location_logs.count
    end
  end

  context "User authentication" do 
    setup do 
      @user = User.create(:name => "user1", :password => "abc")
    end

    should "authenticate user" do 
      post :authenticate, {:format => :json, :user_name => @user.name, :password => @user.password}
      resp = JSON.parse(response.body)
      assert_equal 200, resp["status"]

      post :authenticate, {:format => :json, :user_name => @user.name, :password => "pqr"}
      resp = JSON.parse(response.body)
      assert_equal 302, resp["status"]

      post :authenticate, {:format => :json, :user_name => "a", :password => "pqr"}
      resp = JSON.parse(response.body)
      assert_equal 404, resp["status"]
    end
  end

  context "Attendance" do 
    should "calculate attendance of a user given username" do 
      user = User.create(:name => "user1")
      user.groups.create(:lattitude => "12", :longitude => "12", :name => "group1")
      loc1 = user.location_logs.create(:lattitude => "12", :longitude => "12")
      loc1 = user.location_logs.create(:lattitude => "12", :longitude => "12")
      user.reload
      get :attendance, {:format => :json, :name => user.name}
      resp = JSON.parse(response.body)
      assert_equal 1, resp["attendance"][user.groups.first.name]
    end
  end
end
