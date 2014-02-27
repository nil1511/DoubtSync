class PostController < ApplicationController
	skip_before_action :verify_authenticity_token

  def new
  end
  def index
  	
  end
  def create
# FIXME Post are not saved for users
  	if user_signed_in?
	  	data=params[:post]
	  	post = Post.new(:text => data['text'],:tag => data['tag'],:visibility_to_prof => data['visibility_to_prof'],:spamrate => 0)
	  	post.save
	  	current_user.posts << post
	  	render :text => current_user.id
  	else
  		render :text =>"invalid request"
  	end
  end
end