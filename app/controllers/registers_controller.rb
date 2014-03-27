class RegistersController < Devise::RegistrationsController
  layout 'home'
  def new
  	# TODO Sort array according to name of college
  	@college = College.all;
  	super
  end

end