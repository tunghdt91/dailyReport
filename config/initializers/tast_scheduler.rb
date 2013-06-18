require 'rubygems'; require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
users= User.find_by_sql("Select *from users where group_manager='f' order by group_id asc")
	
	# scheduler.every '120s' do
	# 	users.each do |u|
	# 		managers= User.find_by_sql("Select *from users where group_id=#{u.group_id} and group_manager='t'")
	# 		managers.each do |m|
	# 			UserMailer.sendmail(u.email,m.email).deliver
	# 		end
	# 	end

	# end

scheduler.cron '0 15 08 * * 1-5' do
		#every 17h:00:00 xem link https://github.com/jmettraux/rufus-scheduler/blob/master/README.rdoc
 		users.each do |u|
			managers= User.find_by_sql("Select *from users where group_id=#{u.group_id} and group_manager='t'")
			managers.each do |m|
				UserMailer.sendmail(u.email,m.email).deliver
			end
 		end
end