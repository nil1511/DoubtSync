class SearchController < ApplicationController
	def q

		query = params[:query]
		type = params[:type]
		if query and query.length > 2
			if type == 'post'
				result = Post.where('text like :q',q: '%'+query+'%')
				render :json => result
				return;
			elsif type == 'user'
				#TODO Add abilibty to search via username
				result = Student.where('first_name like :q or last_name like :q',q: '%'+query+'%') + 
						Professor.where('first_name like :q or last_name like :q',q: '%'+query+'%')
				render :json => result
				return;
			elsif type == 'book'
				result = Book.where('name like :q or author like :q or description like :q or tags like :q or contact like :q',q: '%'+query+'%')
				render :json => result
				return;
			elsif type == 'event'
				result = Event.where('name like :q or venue like :q or description like :q',q: '%'+query+'%')
				render :json => result
				return;				
			elsif type == 'internship'
				result = Internship.where('title like :q or required_skills like :q or description like :q or tags like :q',q: '%'+query+'%')
				render :json => result
				return;
			else
				result = Post.where('text like :q',q: '%'+query+'%') +
						Student.where('first_name like :q or last_name like :q',q: '%'+query+'%') + 
						Professor.where('first_name like :q or last_name like :q',q: '%'+query+'%') +
						Book.where('name like :q or author like :q or description like :q or tags like :q or contact like :q',q: '%'+query+'%')+
						Event.where('name like :q or venue like :q or description like :q',q: '%'+query+'%')+
						Internship.where('title like :q or required_skills like :q or description like :q or tags like :q',q: '%'+query+'%')
				render :json => result
				return;
			end
					
		else
			render :json => 'Invalid Request'
		end
	end
end
