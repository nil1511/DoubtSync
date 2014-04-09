class BooksController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :authenticate_user!
	
	def new
	  if user_signed_in? and params['name']

	  	# puts params[:book]
	  	# data=params[:book]
		# book = Book.new(:name => data['name'],:author => data['author'],
		# 	:edition => data['edition'],:description => data['description'],
		# 	:tags => data['tags'],:price => data['price'],:contact => data['contact'],
		# 	:user_id => current_user.id)

		book = Book.new(:name => params['name'],:author => params['author'],
			:edition => params['edition'],:description => params['description'],
			:tags => params['tags'],:price => params['price'],:contact => params['contact'],
			:user_id => current_user.id)
		if !params['book'].nil? and !params['book']['photo'].nil?
			book.photo = params['book']['photo'];
		end
		
	  	book.save
	  	current_user.books << book
	  	#render :text => 'suceeded'
	  	redirect_to '/'

	  else
	  	render :text => 'failed'
	  end
	end

	def show
		id =params[:id]
	    book = Book.find_by_id(id)
	    if !book.nil?
	      render :json => book
	    else
	      render :text => "invalid request | Book does not exit"
	    end
	end

	def edit
		#TODO Edit for books
	end

	def destroy
		id =params[:id]
	    book = Book.find_by_id(id)
	    if !book.nil?

	    	book.destroy
	      	render :text => "Book deleted"

	    else
	      render :text => "invalid request | Book does not exit"
	    end
	end
end
