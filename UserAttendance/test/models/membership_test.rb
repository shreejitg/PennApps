require 'test_helper'
 
class MembershipTest < ActiveSupport::TestCase
	context "Membership Creation" do
		should "create membership" do 
			mem1 = Membership.create(:role => "Hello")
			assert_equal 1, Membership.count
		end

		should "update membership" do 
			mem1 = Membership.create(:role => "Hello")
			mem1.update(:role => "Bye")
			mem1.save!
			assert_equal "Bye", mem1.role
		end

		should "delete membership" do 
			mem1 = Membership.create(:role => "Hello")
			mem1.delete
			assert_equal 0, Membership.count
		end 

		should "link user and group" do 
			user = User.create(:name => "abd")
			group = Group.create(:name => "group1")
			user.memberships.create(:user => user, :group => group)
			user.save!
			assert_equal 1, user.groups.size
			assert_equal 1, group.users.size
		end
	end
end