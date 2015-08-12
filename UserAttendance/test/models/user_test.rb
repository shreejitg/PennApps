require 'test_helper'
 
class UserTest < ActiveSupport::TestCase
	context "User Creation" do
		should "create user" do 
			user1 = User.create(:name => "Hello", :password => "abc")
			assert_equal 1, User.count
		end

		should "update user" do 
			user1 = User.create(:name => "Hello", :password => "abc")
			user1.update(:name => "Bye")
			user1.save!
			assert_equal "Bye", user1.name
		end

		should "delete user" do 
			user1 = User.create(:name => "Hello", :password => "abc")
			user1.delete
			assert_equal 0, User.count
		end 
	end

end