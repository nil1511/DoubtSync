class UsersController < ApplicationController
	before_filter :authenticate_user!
	
	layout 'users'

	#TODO make sure user does not register with reserved keyword
	#TODO Validation for profile form
	
	def index
		@id = params['id']
		if @id.nil?
			@id = current_user.id
		end
		if @id.is_number?
			@user = User.find_by_id(@id)
			if @user.nil?
				#TODO 404 pages here
				render :text => "User does not exist"
			else
				get_details
			end
		else
			@user = User.find_by username: @id
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				get_details
			end
		end
	end

	def manage
		if current_user.role.name.eql? "student" or current_user.role.name.eql? "ambassador"
			@student = Student.find_by user_id: current_user.id
			render 'profile'
		else current_user.role.name.eql? "professor"
			@prof = Professor.find_by user_id: current_user.id
			#TODO Edit profile for professor coming soon
			render 'editprofile_prof'
		end
	end
	
	def save
		#TODO Check validation
		#FIXME Dry
		if current_user.role.name.eql? "student" or current_user.role.name.eql? "ambassador" 
				student = current_user.profile
				dob = params['user']
				mobile = params['mobile']
				gender = params['gender'].eql?"male"
				student.update(:first_name => params['first_name'],:last_name => params['last_name'],
					:degree => params['degree'],:graduate_year => params['graduate'],:gender => gender,
					:dob => dob['dob'],:mobile => mobile['phone'])
				student.user.avatar = params['user']['avatar'];
				student.user.save
				student.save
				redirect_to '/users/profile'
			# end
		else current_user.role.name.eql? "professor"
				prof = current_user.profile
				dob = params['user']
				mobile = params['mobile']
				gender = params['gender'].eql?"male"
				prof.update(:first_name => params['first_name'],:last_name => params['last_name'],
					:aoi => params['aoi'],:gender => gender,
					:dob => dob['dob'],:mobile => mobile['phone'])
				prof.user.avatar = params['user']['avatar'];
				prof.user.save
				prof.save
				redirect_to '/users/profile'
			#render :text =>  "TODO"+current_user.role.name
		end
	end

	def following
	    #@title = "Following"
	    user = User.find(params[:id])
	    @users = user.followed_users
	    
	    @userlist = @users.map do |u|
  		{ :id => u.id, 
  		  :name => u.name, 
  		  :photo => u.avatar.url(:thumb),
  		  :college => u.college.name, 
  		  :username => u.username }
  		end

	    render :json => @userlist
	end

  	def followers
	    @title = "Followers"
	    @user = User.find(params[:id])
	    @users = @user.followers
	    @userlist = @users.map do |u|
  		{ :id => u.id, 
  		  :name => u.name, 
  		  :photo => u.avatar.url(:thumb), 
  		  :college => u.college.name,
  		  :username => u.username }
  		end
	   	render :json => @userlist
  	end

  	def profile
  		params = {};
  		params['id'] = current_user.id;
  		index;
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
			if !@user.profile != nil? 
				#TODO Implement a proper page
				render :text => "Profile does not exits"
			else
				@prof = @user.profile
					render 'profprofile'
			end
			#TODO Profile page for professor
		 	#render :text => "professor profile comming soon"

		elsif @user.role.name.eql? "ambassador"
			# TODO create new page using partial views
			@student = @user.profile
			render 'index'
		end
	end
end