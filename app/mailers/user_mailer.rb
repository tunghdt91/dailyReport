class UserMailer < ActionMailer::Base
  default from: :"tunghdt91@gmail.com"

  def welcome_email(user)
    host = "http://localhost:3000/users"
    @url = "http://localhost:3000/users"
    @usr_name = user.email
    @usr_passwd = user.password
    mail(to: user.email, subject: "no-reply")
  end

  def mail_to_admin(user)
    @usr_name = user.email
    @usr_id = user.id
    @usr_create_at = Time.new.inspect
    @usr_passwd = user.password
    @usr_md5 = user.md5
    mail(to: "framgia.jp@gmail.com", subject: 'Active account')  
  end

  def sendmail(user,manager)
    @usr= user
    @mng= manager
    query ="Select *from users where email='#{user}'"
    @g_id=User.find_by_sql(query)[0].group_id
    @usr_id=User.find_by_sql(query)[0].id
     mail(to: manager, subject: "#{user} Report !")
  end
end
