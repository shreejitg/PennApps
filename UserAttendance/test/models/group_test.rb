require 'test_helper'
 
class GroupTest < ActiveSupport::TestCase
	context "Group Creation" do
		should "create group" do 
			group1 = Group.create(:name => "Hello")
			assert_equal 1, Group.count
		end

		should "update group" do 
			group1 = Group.create(:name => "Hello")
			group1.update(:name => "Bye")
			group1.save!
			assert_equal "Bye", group1.name
		end

		should "delete group" do 
			group1 = Group.create(:name => "Hello")
			group1.delete
			assert_equal 0, Group.count
		end 
	end
end