class RegistersController < Devise::RegistrationsController
  layout 'home'
  def new
  	# TODO Use Select2 dropdown Plugin while selecting college  
  	super
  end

  def create
  	
  	super
	@user.college_id = params['college_id'].to_i
  	@user.save
  	
  end
    
end