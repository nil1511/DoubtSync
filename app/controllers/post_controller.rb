class PostController < ApplicationController
	skip_before_action :verify_authenticity_token

  # TODO Check Authentication while crud
  def index
    render :json => current_user.posts
  end

  def create
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

  def edit
    # TODO Edit a post
  end

  def destroy
    # TODO Delete a post
  end
  
  def show
    id =params[:id]
    post = Post.find_by_id(id)
    if !post.nil?
      render :json => post
    else
      render :text => "invalid request | Post does not exit"
    end

  end

end