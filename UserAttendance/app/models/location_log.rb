class LocationLog < ActiveRecord::Base
	belongs_to :user

	def self.distance(lat1, lat2, long1, long2)
		r = 6373
		dlon = (long2 - long1) * Math::PI / 180
		dlat = (lat2 - lat1) * Math::PI / 180
		a = (Math.sin(dlat/2))**2 + Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2))**2 
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a) ) 
		d = r * c
		d
	end
end