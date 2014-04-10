class UserMailer < ActionMailer::Base
  default from: 'info@doubtsync.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://doubtsync.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end