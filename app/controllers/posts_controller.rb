class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token

  # TODO Check Authentication while crud
  def index
    render :json => Post.from_users_followed_by(current_user)
  end

  def create
  	if user_signed_in? and params[:post]
	  	data=ActiveSupport::JSON.decode(params[:post])
      puts data;
      puts data['text'];
      #FIXME Added option to save tags and tag
      
      #,:htags => data['htags']
      # if !data
      # render :text =>"invalid request"
      # return
      # end  
      # print params
	  	post = Post.new(:text => data['text'],:tagged_users => data['tags'],:visibility_to_prof => data['visibility_to_prof'],:spamrate => 0)
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