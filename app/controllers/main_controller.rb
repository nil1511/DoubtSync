class MainController < ApplicationController
	before_filter :authenticate_user!
  def index
  	redirect_to :action => 'feed'
  end
  # TODO add client side validation for Registeration and then login
  def feed
  	@posts = Post.from_users_followed_by(current_user)
  end
  def user
  	key = params['search']
  	student = Student.where('first_name LIKE :s', s:'%'<<key<<'%')
  	professor = Professor.where('first_name LIKE :s', s:'%'<<key<<'%')
  	@student = student.to_json(only: [:id,:first_name])
  	@professor = professor.to_json(only: [:id,:first_name])
  	#FIXME Merge json
  	render :json => @student
  end
end
