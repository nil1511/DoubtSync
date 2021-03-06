class InternshipsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!

	def new
	  if  params['title'] and current_user.role.name == "professor"

		internship = Internship.new(:title => params['title'],:start_date => params['start_date'],
			:description => params['description'],:tags => params['tags'],:duration => params['duration'],
			:location => params['location'],:deadline => params['deadline'],:opening => params['opening'],
			:url => params['url'],:eligible_students => params['eligible_students'],
			:required_skills => params['required_skills'],:professor_id => current_user.profile.id)

	  	if internship.save
		  	current_user.profile.internships << internship
		  	#render :text => 'suceeded'
		  	redirect_to '/'
	  	else
	  		render :text => 'some thing went wrong plz report a bug'
	  	end

	  else
	  	render :text => 'failed'
	  end
	end

	def show
		id =params[:id]
	    internship = Internship.find_by_id(id)
	    if !internship.nil?
		 	# if current_user.role.name == "professor"
			# 	@message
			# else
			# 	render :text => 'some thing went wrong plz report a bug'
			# end
	      render :json => internship
	    else
	      render :text => "invalid request | Internship does not exit"
	    end
	end

	def list
		#TODO Show internship which have still not crossed deadline
		if current_user.role.name == "student"
			@internship = Internship.all
			render 'list'
		else
			render :json => 'Only Student can see this page'
		end
	end

	def myinternship
		if current_user.role.name == "professor"
			@internship = current_user.profile.internships
			render 'plist'
		else
			render :json => 'Invalid Request'
		end
	end

	def internship_response
		internship_id = params[:id];
		internship = Internship.find_by_id(internship_id)
		if internship.professor == current_user.profile
			@applications = internship.internship_applications
			render 'response'
		else
			render :json => 'Unauthorized Request'
		end
	end

	def apply
		
		data = params[:data]
		internship_id = params[:id];
		message = params[:message];
		resume = data['file'];
		internship = Internship.find_by_id(internship_id)

		if !internship.nil? and current_user.role.name == "student"
			puts internship;
			result = InternshipApplication.create(internship_id: internship.id,student_id: current_user.profile.id,
				message: message,resume: resume);
			puts result;
			if result
				
				render :json => "Your Application SuccessFully Submitted"
			else
				render :json => "Something Went Wrong"
			end
		else
			render :json => "Invalid request"
		end
	end

	def edit
		#TODO Edit for internship
	end

	def destroy
		id =params[:id]
	    internship = Internship.find_by_id(id)
	    if !internship.nil?

	    	internship.destroy
	      	render :text => "Internship deleted"

	    else
	      render :text => "invalid request | Internship does not exit"
	    end
	end
end
