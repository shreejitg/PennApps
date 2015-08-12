class GroupController < ApplicationController
	def index
		@groups = Group.all
		respond_to do |format|
			format.json {
				render :json => {:status => 200, :groups => @groups}
			}
		end
	end

	def group_params
		params.require(:group).permit(:name, :role, :lattitude, :longitude)
	end

	def users
		respond_to do |format|
			format.json {
				group = Group.find_by_name(params[:name])
				render :json => {:status => 200, :users => group.users}
			}
		end
	end

	def create
		respond_to do |format|
			format.json {
				existing_group = Group.find_by_name(params[:group][:name])
				if existing_group
					render :json => {:status => 422, :reason => "Group name already exists"}
				else
					group = Group.create(group_params)
				user = User.find_by_name(params[:user_name])
				user.memberships.create(:user => user, :group => group, :role => "Leader")
				user.save!
				render :json => {:status => 201}
				end
				
			}
		end
	end

	def add_user
		respond_to do |format|
			format.json {
				group = Group.find_by_name(params[:group_name])
				if group.nil?
					render :json => {:status => 422, :reason => "No such group"}
				else
					user = User.find_by_name(params[:user_name])
					if user.nil?
						render :json => {:status => 422, :reason => "No such username"}
					else
						if user.groups.collect{|group| group.name}.include?(group.name)
							render :json => {:status => 422, :reason => "User already part of that group"}
						else
							user.memberships.create(:user => user, :group => group, :role => params[:role])
							user.save!
							render :json => {:status => 201}
						end
							
					end
					
				end
			}
		end
	end

	def remove_user
		respond_to do |format|
			format.json {
				user = User.find_by_name(params[:user_name])
				group = Group.find_by_name(params[:group_name])

				user.memberships.find_by_group_id(group.id).destroy

				render :json => {:status => 203}				
			}
		end
	end
end