class GroupsController < ApplicationController
	def new
	end

	def show
		group_id = current_user.group_id 
		@users = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{group_id} and group_manager='f'")
		@users_manager = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{group_id} and group_manager='t' ")
		
	end

	def index
	end

	def group_report
		if current_user.group_manager?
			@users = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{current_user.group_id}") ## all user in group, not manager
		else
			flash[:error] = "You not manager this group!"
			redirect_to root_path
		end
	end
end
