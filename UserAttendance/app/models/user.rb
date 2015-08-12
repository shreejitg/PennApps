class User < ActiveRecord::Base
	has_many :memberships
	has_many :groups, :through => :memberships
	has_many :location_logs

	def as_json(options = {})
		options[:except] ||= [:password]
     	super(options)
	end
end