class MessagesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!

	def send_message
		user = User.find(params[:id])
		if !user.nil?
			data = ActiveSupport::JSON.decode(params['message'])

			current_user.send_message!(user,data['text'])
			render :json => user.id
		else
			render :json => 'Failed'
		end
	end

	def list_message
		type = params[:format]
		@messages = Message.where('sender_id = :id or receiver_id = :id',id:current_user.id)
		if type.nil?
			render 'show'
		elsif type == 'json'
			render :json => @messages
		else
			render 'show'
		end
	end
end
