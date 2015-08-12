class UserController < ApplicationController
	def index
		@users = User.all
		respond_to do |format|
			format.html {}
			format.json {
				render :json => {:status=>200, :users=>@users}
			}
		end
	end

    def user_params
       params.require(:user).permit(:name, :password)
    end

    def groups
    	respond_to do |format|
    		format.json {
    			user = User.find_by_name(params[:name])
    			if user.nil?
    				render :json => {:status => 404, :reason => "No such user"}
    			else
    				render :json => {:status => 200, :groups => user.groups}
    			end
    		}
    	end
    end

    def authenticate
    	respond_to do |format|
    		format.json {
    		user = User.find_by_name(params[:user_name])
    		if user.nil?
    			render :json => {:status => 404, :reason => "No such user exists"}
    		else
    			if user.password == params[:password]
    				render :json => {:status => 200}
	    		else
	    			render :json => {:status => 302}
	    		end
    		end
    			
    		}
    	end
    end

	def create
		respond_to do |format|
			format.json {
				hash = params[:user]
				username_check  = User.find_by_name(hash[:name])
				if username_check
					render :json => {:status => 422, :reason => "Username already exists"}
				else
					user = User.create(user_params)
					user.save!
					render :json => {:status => 201, :user_id => user.id }
				end
			}
		end
	end

	def update
		respond_to do |format|
			format.json {
			hash = params[:user]
			user = User.find_by_name(hash[:name])
			if user.nil?
				render :json => {:status => 404, :reason => "User not found"}
			else
				user.update(hash)
				render :json => {:status => 200, :user_id => user.id}
			end
		}
		end
	end

	def delete
	end

	def location_params
		params.require(:location_log).permit(:lattitude, :longitude)
	end

	def log_location
		respond_to do |format|
			format.json {
				user = User.find_by_name(params[:user_name])
				location_log = LocationLog.create(location_params)
				user.location_logs << location_log
				user.save!
				render :json => {:status => 201}
			}
		end
	end

	def attendance
		respond_to do |format|
			format.json {
				user = User.find_by_name(params[:name])
				if user.nil?
					render :json => {:status => 404, :reason => "No such user"}
				else
					result = {}
					if user.groups.empty?
						render :json => {:status => 422, :reason => "No groups for this user"}
					else
						# p user.groups
						# p user.location_logs.where("updated_at between ? and ?", Time.now - 1.days, Time.now)
						user.groups.each do |group|
							user.location_logs.where("updated_at between ? and ?", Time.now - 1.days, Time.now).each do |loc|

								dist = LocationLog.distance(loc.lattitude.to_f, group.lattitude.to_f,
								 loc.longitude.to_f, group.longitude.to_f)
								if dist < 0.050
									result[group.name] = 1

								else
									result[group.name] = 0
								end
							end
						end
						render :json => {:status => 200, :attendance => result}
					end
				end
			}
		end
	end
end
