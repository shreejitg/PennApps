require 'test_helper'
 
class LocationLogTest < ActiveSupport::TestCase
	context "LocationLog Creation" do
		should "create location log" do 
			loc1 = LocationLog.create(:lattitude => "39.1212", :longitude => "12.12")
			assert_equal 1, LocationLog.count
		end

		should "update location log" do 
			loc1 = LocationLog.create(:lattitude => "39.1212", :longitude => "12.12")
			loc1.update(:lattitude => "Bye")
			loc1.save!
			assert_equal "Bye", loc1.lattitude
		end

		should "delete location log" do 
			loc1 = LocationLog.create(:lattitude => "39.1212", :longitude => "12.12")
			loc1.delete
			assert_equal 0, LocationLog.count
		end 
	end

	context "User locations" do 
		should "add user locations" do 
			user = User.create(:name => "abc")
			loc1 = LocationLog.create(:lattitude => "12", :longitude => "12")
			loc2 = LocationLog.create(:lattitude => "12", :longitude => "12")
			user.location_logs << loc1
			user.location_logs << loc2
			user.save!
			assert_equal 2, user.location_logs.size 
		end
	end

	context "Distance" do 
		should "calculate distance" do
			 lat1 = 38.898556
			 lat2 = 38.897147
			 long1 = -77.037852
			 long2 = -77.043934
			 dist = LocationLog.distance(lat1, lat2, long1, long2)
			 assert_equal 0.549, dist
		end
	end
end