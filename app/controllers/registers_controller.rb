class RegistersController < Devise::RegistrationsController
  layout 'home'
  def new
  	# TODO Sort array according to name of college
  	
  	super
  end

  def create
  	# TODO Sort array according to name of college
  	super
	@user.college_id = params['college_id'].to_i
  	@user.save
  	
  end
    
end