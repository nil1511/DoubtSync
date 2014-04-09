class EventsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!

	def new
	  if user_signed_in? and params[:event]	  	
	  	data=params[:event]
		event = Event.new(:name => params['name'],:venue => params['venue'],
			:duration => params['duration'],:description => params['description'],
			:date => params[:event]['date'],:url => params['url'],
			:college_id => current_user.college.id,:user_id => current_user.id)
			
			puts event
		if !params['event'].nil? and !params['event']['photo'].nil?
			event.photo = params['event']['photo'];
		end
			
	  	if event.save
	  	current_user.events << event
	  	redirect_to '/'
	  	else
	  	render :text => 'please fill all the details'
	  	end
	  else
	  	render :text => 'failed'
	  end
	end

	def show
		date =params[:date]
	    event = Event.where('date like :d',d:'%'+date+'%')
	    if !event.nil?
	      render :json => event.to_json(only: [:name,:description,:id])
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
