class MainController < ApplicationController
	before_filter :authenticate_user!
  def index
  	redirect_to :action => 'feed'
  end
  #TODO add client side validation for Registeration and then login
  def feed
    if current_user.profile.first_name.to_s == ''
      redirect_to '/users/manage'
    end
  	post = Post.from_users_followed_by(current_user).paginate(page: params[:page])
    event =  Event.where('college_id= :cid',cid: current_user.college.id) 
    book = Book.all
    data = post + event + book
    @data = data.sort_by {|a| a.created_at }.reverse
  end

  def user
  	key = params['search']
  	student = Student.where('first_name LIKE :s', s:'%'<<key<<'%')
  	professor = Professor.where('first_name LIKE :s', s:'%'<<key<<'%')
  	@userlist = student.map do |u|
    { :id => u.user_id, 
      :name => u.first_name << ' ' <<u.last_name, 
    }
    end
    
    @userlist += professor.map do |u|
    { :id => u.user_id, 
      :name => u.first_name << ' '<< u.last_name, 
    }
    end
  	
    render :json => @userlist

  end

  def topic
    key = params['search']
    topic = Topic.where('name LIKE :s', s:'%'<<key<<'%')
    @topic = topic.to_json(only: [:id,:name])  
    render :json => @topic
  end

  def notificationlist
    @notifications = current_user.notifications.to_json(only: [:id,:text,:read,:url])  
    render :json => @notifications
  end

  def unreadmsg
    msg = current_user.unread_message

    @msg = msg.map do |u|
    { :id => u.id,
      :name => u.sender.name,
      :text => u.text,
      :pic =>u.sender.avatar('thumb'),
      :read => u.read
    }
  end
    render :json => @msg
  end
end
