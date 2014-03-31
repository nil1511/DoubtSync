class CommentsController < ApplicationController
	skip_before_action :verify_authenticity_token

  # TODO Check Authentication while crud

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
      data=ActiveSupport::JSON.decode(params[:comment])
      pid = data['post_id']
      format= 'json'
      puts data;
    	comment = Comment.new(:text => data['text'],:spamrate => 0)
    	post = Post.find_by_id(pid)
    	if !post.nil?
    		puts post
      	comment.save
      	post.comments << comment
      	current_user.comments << comment
#      	render get_type format => post
#        TODO use function
        render format.to_sym => '1'
      else
      	render format.to_sym => "failed"
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