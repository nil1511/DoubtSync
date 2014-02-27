class CommentController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
  	# TODO Get comments for a particular post
  end

  def create
  	if user_signed_in?
	  	data=params[:comment]
	  	comment = Comment.new(:text => data['text'],:tag => data['tag'],:spamrate => 0)
	  	post = Post.find(data['post_id'])
	  	if !post.nil?
	  		puts post
	  	comment.save
	  	post.comments << comment
	  	current_user.comments << comment
	  	render :text => "success"
	  else
	  	render :text => "failed"
	  end
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

end