class CollegesController < ApplicationController
  def new
  end
  def create
  	# Todo checkvalidation
  	email = params['email']
  	college_name = UpComingCollege.create(:name => params['college_name'], :email => email)
  	# todo make a render page
  	# TODO create a job of creating registration link
  	authcode = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
  	#Fixme use find instead for ambassador instead of value i.e. 3
  	register = Sregistration.create(:email => email, :authcode => authcode, :role_id => 3);
  	message = college_name.id.to_s << '&email=' << email << '&authcode=' << authcode;
  	render :text => "We will contact you via email " << message.to_s
  end

  # TODO Check may be a bugs as we are not storing college name
  def show
  	email = params['email']
  	authcode = params['authcode']
  	ambassador = Sregistration.find_by(:email => email, :authcode => authcode, :role_id => 3);
  	if ambassador
  	render :text => ambassador.email+" " << email << authcode;
  	else
  	render :text => 'Invalid link'
  	end

  end
end