class TopicsController < ApplicationController
	before_filter :authenticate_user!
end
