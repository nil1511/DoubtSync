class MainController < ApplicationController
	before_filter :authenticate_user!
  def index
  	redirect_to :action => 'feed'
  end
  # TODO add client size validation for Registeration and then login
  def feed
  	#FIXME Check header's nav bar on corresponding erb
  	@posts = Post.from_users_followed_by(current_user)  	
  end
end
