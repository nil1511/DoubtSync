class TopicsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!
	belongs_to :user	
end
