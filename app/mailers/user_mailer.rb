class UserMailer < ActionMailer::Base
  default from: :"simre102@gmail.com"

  def welcome_email(user)
    host = "http://localhost:3000/users"
    @url = "http://localhost:3000/users"
    @usr_name = user.email
    @usr_passwd = user.password
    mail(to: user.email, subject: "Welcome to My Awesome Site")
  end

  def mail_confirm(user)	
  end
end
