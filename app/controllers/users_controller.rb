class UsersController < ApplicationController

	#TODO make sure user does not register with reserved keyword
	#TODO Validation for profile form
	def index
		@id = params['id']
		if @id.is_number?
			@user = User.find_by_id(@id)
			if @user.nil?
				#TODO 404 pages here
				render :text => "User does not exist"
			else
				get_details
				# TODO Show his details
			end
		else
			@user = User.find_by username: @id
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				# TODO Show his details
				render :text => "Found him"
			end
		end
	end

	def manage
		if current_user.role.name.eql? "student"
			@student = Student.find_by user_id: current_user.id
			
			render 'profile'
		else
			render :text => current_user.role.name
		end
	end
	def save
		#TODO Check validation
		#FIXME Dry
		if current_user.role.name.eql? "student"
				student = current_user.profile
				dob = params['user']
				mobile = params['mobile']
				gender = params['gender'].eql?"male"
				student.update(:first_name => params['first_name'],:last_name => params['last_name'],
					:degree => params['degree'],:graduate_year => params['graduate'],:gender => gender,
					:dob => dob['dob'],:mobile => mobile['phone'])
				student.save
				render :text =>  "updated"
			# end
		else
			render :text =>  "TODO"+current_user.role.name
		end

	end

	def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    @users = @user.followed_users.paginate(page: params[:page])
	    render 'show_follow'
	end

  	def followers
	    @title = "Followers"
	    @user = User.find(params[:id])
	    @users = @user.followers.paginate(page: params[:page])
	    render 'show_follow'
  	end

	def get_details
		if @user.role.name.eql? "student"
			if !@user.profile != nil? 
				#TODO Implement a proper page
				render :text => "Profile does not exits"
			else
				@student = @user.profile
					render 'index'
			end
		elsif @user.role.name.eql? "professor"
			#TODO Profile page for professor
			render :text => "professor profile comming soon"
		elsif @user.role.name.eql? "ambassador"
			#TODO Profile page for ambassador
			render :text => "ambassador profile comming soon"
		end
	end
end