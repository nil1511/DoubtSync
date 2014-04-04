class TopicsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!
	def index
		name = params[:name]
		@posts = Topic.find_by_name(name)
		
		if @posts.nil?
			render :text => "No post in this topic"
		else
			@posts = @posts.posts;
			
		end
	end
	
end
