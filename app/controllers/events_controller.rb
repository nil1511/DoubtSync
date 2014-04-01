class EventsController < ApplicationController
	before_filter :authenticate_user!

	def new
	  if user_signed_in? and params[:event]
	  	data=ActiveSupport::JSON.decode(params[:event])
		event = Event.new(:name => data['name'],:venue => data['venue']
			,:duration => data['duration'],:description => data['description']
			,:date => data['date'],:url => data['url']
			,:college_id => current_user.college.id,:user_id => current_user.id)
	  	event.save
	  	current_user.events << event
	  	render :text => 'suceeded'
	  else
	  	render :text => 'failed'
	  end
	end

	def show
		id =params[:id]
	    event = Event.find_by_id(id)
	    if !event.nil?
	      render :json => event
	    else
	      render :text => "invalid request | event does not exit"
	    end
	end

	def edit
		#TODO Edit for events
	end

	def destroy
		id =params[:id]
	    event = Event.find_by_id(id)
	    if !event.nil?
	    	event.destroy
	      	render :text => "event deleted"
	    else
	      render :text => "invalid request | event does not exit"
	    end
	end
end
