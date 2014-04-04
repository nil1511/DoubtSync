class FollowedTopicsController < ApplicationController
     before_filter :authenticate_user!

  def create
    @topic = Topic.find(params[:followed_topic][:topic_id])
    if @topic.nil?
      render :text => 'Some Error occured'
    else
      FollowedTopic.create(topic_id: @topic.id,user_id: current_user.id)
    end

    redirect_to '/'
  end

  def destroy
    
    @topic = FollowedTopic.find_by(id: params[:id])
    @topic.destroy;
    redirect_to '/'
  end
end