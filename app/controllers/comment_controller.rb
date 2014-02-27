class CommentController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
  	id =params[:id]
    post = Post.find_by_id(id)
    if !post.nil?
      render :json => post.comments
    else
      render :text => "invalid request | Post does not exit"
    end
  end

  def create
  	if user_signed_in?
	  	data=params[:comment]
	  	comment = Comment.new(:text => data['text'],:tag => data['tag'],:spamrate => 0)
	  	post = Post.find_by_id(data['post_id'])
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
    # TODO Modularized functions DRY Code
    id =params[:id]
    data=params[:comment]
    comment = Comment.update(id,text: data['text'],tag: data['tag'])
    if !comment.nil?
      render :text => "saved"
    else
      render :text => "invalid request | Post does not exit"
    end
  end

  def destroy
    id =params[:id]
    comment = Comment.find_by_id(id)
    if !comment.nil?
      comment.destroy
      render :text => "comments Deleted"
    else
      render :text => "invalid request"
    end
  end

end