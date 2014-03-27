class MainController < ApplicationController
	before_filter :authenticate_user!
  def index
  	redirect_to :action => 'feed'
  end
  # TODO add client side validation for Registeration and then login
  def feed
  	@posts = Post.from_users_followed_by(current_user)  	
  end
end
