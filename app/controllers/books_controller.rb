class BooksController < ApplicationController
	before_filter :authenticate_user!
	
	def new
	  if user_signed_in? and params[:book]
	  	data=ActiveSupport::JSON.decode(params[:book])
		book = Book.new(:name => data['name'],:author => data['author'],
			:edition => data['edition'],:description => data['description'],
			:tags => data['tags'],:price => data['price'],:contact => data['contact'],
			:user_id => current_user.id)
	  	book.save
	  	current_user.books << book
	  	render :text => 'suceeded'
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
