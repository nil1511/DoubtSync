class HomeController < ApplicationController
	layout 'home'
	def index
		if current_user
			redirect_to '/main/feed'
		end
	end
end
