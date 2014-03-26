class CollegesController < ApplicationController
  def new
  end
  def create
  	# Todo checkvalidation
  	email = params['email']
    college_name = params['college_name']
  	UpComingCollege.create(:name => params['college_name'], :email => email)
  	# todo make a render page
  	# TODO create a job of creating registration link
  	authcode = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
  	#Fixme use find instead for ambassador instead of value i.e. 3
  	register = AmbassadorRegistration.create(:email => email, :authcode => authcode, :college_name => college_name);
  	message = college_name.id.to_s << '&email=' << email << '&authcode=' << authcode;
  	render :text => "We will contact you via email " << message.to_s
  end

  def show
    
  end

  def update
  	email = params['email']
  	authcode = params['authcode']
    password = params['password']
    username = params['username']
    ambassador = AmbassadorRegistration.find_by(:email => email, :authcode => authcode);

  	if ambassador  	
    #TODO Create college and set its ambassador
    # TODO Check if email or username exists or not and don't fix value of role
    college = College.create(:name => ambassador.college_name);
    user = User.create(:email => email, :password => password,
      :password_confirmation => password, :role_id => 3,
      :username => username, :college_id => college.id);

    college.user_id = user.id
    college.save

    render :text => ambassador.email+" " << email << authcode;

  	else
  	render :text => 'Invalid link'
  	end

  end
end