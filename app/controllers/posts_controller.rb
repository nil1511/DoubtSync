class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!

  def index
    render :json => Post.from_users_followed_by(current_user)
  end

  def list
    id =params[:id]
    user = User.find_by_id(id)
    if user.nil?
      render :json => "User does not exisit" 
      return
    end
    @posts=User.find_by_id(id).posts
    render :json => @posts.to_json(only: [:id,:text,:tagged_users,:htags,:visibility_to_prof,:upvotes,:downvotes])
  end

  def create
  	if params[:post]
	  	data=ActiveSupport::JSON.decode(params[:post])
	  	post = Post.new(:text => data['text'],:tagged_users => data['tags'],:htags => data['htags'],:visibility_to_prof => data['visibility_to_prof'])      
	  	post.save
	  	current_user.posts << post
      Delayed::Job.enqueue(NotifyPostaddTopic.new(post.id))

	  	render :text => post.id

  	else
  		render :text =>"invalid request"
  	end
  end

  def edit
    # TODO Edit a post
  end

  def spam
    id =params[:id]
    post = Post.find_by_id(id)
    if !post.nil?
      if post.spam.to_s.include? (current_user.id.to_s+',')
        render :text => 'already'
        return;
      end
      post.spam = post.spam.to_s + current_user.id.to_s + ','
      if (post.spam.to_s.count(',')==5)
        post.user.profile.spamrate =post.user.profile.spamrate.to_i+ 1 
        post.user.save
        post.destroy

      else
      post.save
      end
      render :text => 'true'
    else
      render :text => "false"
    end
  end

  def file

    io=params[:files]
    file = io.open;
    render :text => file.read.to_s;
  end

  def destroy
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
    type = params[:format]

    @post = Post.find_by_id(id)

    if !@post.nil? and type.nil?
      @posts = Array.new()
      @posts << @post
      render 'show'
    elsif !@post.nil? and type=='json'
      render :json => @post
    else
      render :text => "invalid request | Post does not exit"
    end
  end

end