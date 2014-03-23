class UserController < ApplicationController
	def index
		@id = params['id']
		if @id.is_number?
			@user = User.find_by_id(@id)
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				# TODO Show his details
				render :text => "Found him"
			end
		else
			@user = User.find_by username: @id
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				# TODO Show his details
				render :text => "Found him"
			end
		end

	end
end
