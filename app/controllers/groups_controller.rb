class GroupsController < ApplicationController
	before_filter :checked_manager, only: [:set_role, :update]
	before_filter :checked_read, only: [:group_report]

	def new
	end

	def show
		if !current_user.group_id?
			flash[:error] = "You are not in  group"
			redirect_to root_path
		else
		group_id = current_user.group_id 
		@users = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{group_id} and group_manager='f'")
		@users_manager = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{group_id} and group_manager='t' ")
		end
	end

	def index
	end

	def group_report
			@users = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{current_user.group_id}") ## all user in group	
	end

	def member_report
		@user = User.find(params[:format])
		response.headers['Content-Disposition'] = 'attachment; filename="' + @user.email + '.xls"'
    	render "member_report.xls.erb"
	end

	def set_role
		@group = Group.find_by_user_id(params[:format])
	end

	def update
		@group = Group.find(params[:id])
		if(params[:group][:r]=="1")
			@group.update_attributes(r: true)
		end
		if(params[:group][:r]=="0")
			@group.update_attributes(r: false)
		end
		
		if(params[:group][:e]=="1")
			@group.update_attributes(e: true)
		end
		if(params[:group][:e]=="0")
			@group.update_attributes(e: false)
		end

		if(params[:group][:d]=="1")
		@group.update_attributes(d: true)
		end

		if(params[:group][:d]=="0")
		@group.update_attributes(d: false)
		end
		redirect_to group_path
	end
end
