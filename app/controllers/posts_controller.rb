class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!
  # TODO Check Authentication while crud
  def index
    render :json => Post.from_users_followed_by(current_user)
  end

  def create
  	if user_signed_in? and params[:post]
	  	data=ActiveSupport::JSON.decode(params[:post])
	  	post = Post.new(:text => data['text'],:tagged_users => data['tags'],:htags => data['htags'],:visibility_to_prof => data['visibility_to_prof'],:spamrate => 0)      
	  	post.save
	  	current_user.posts << post
      Delayed::Job.enqueue(NotifyPostaddTopic.new(post.id,post.tagged_users,post.htags))

	  	render :text => post.id

  	else
  		render :text =>"invalid request"
  	end
  end

  def edit
    # TODO Edit a post
  end

  def destroy
    # TODO Give JSON response
    id =params[:id]
    post = Post.find_by_id(id)
    if post.user == current_user
      a=post.destroy
      render :text => 'true'
    else
      render :text => "You are not autorized to delete this post"
    end

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