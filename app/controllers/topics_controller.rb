class TopicsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!
	def index
		name = params[:name]

		@topic = Topic.find_by_name(name)
		
		if @topic.nil?
			render :text => "No post in this topic"
		else
			@posts = @topic.posts;
		end
	end
	
end
