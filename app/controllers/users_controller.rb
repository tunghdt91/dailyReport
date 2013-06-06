class UsersController < ApplicationController
	include UsersHelper
	#before_filter :checked_admin?, only: [:edit, :all_user]
	
	 def index
    	#headers['Content-Type'] = "application/vnd.ms-excel"
    	headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    	#headers['Cache-Control'] = ''
    	@users = User.find(:all)
  	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		create_pass_for_user @user
		@user.md5 = Digest::MD5.hexdigest(@user.email)
		if @user.save
			UserMailer.welcome_email(@user).deliver
			UserMailer.mail_to_admin(@user).deliver
			@group =  Group.new
			@group.user_id = @user.id
			@group.save

			if !@user.active
			flash[:notice] = "Thank You !Your Account is Created.Please wait admin active !"
			end
			sign_in @user
			redirect_to root_path
		else
			
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@reports = @user.reports.all
		
		#redirect_to  root_path
	end

	def all_user
		if  signed_in?
			if current_user.admin?
				@users = User.paginate(page: params[:page], per_page: 20)
				#@users = User.find_by_sql("select *from users ORDER BY created_at DESC")
			else
				flash[:notice] = "You do not permission !"
				redirect_to root_path
			end
		else
			flash[:error] = "Please login !"
			redirect_to root_path
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update  # update user and set to table group
		@user =  User.find(params[:id].to_i)
	 if params[:user].present? || params[:upload].present?
		if params[:user].present?
			@group = Group.find_by_user_id(params[:id].to_i)
			group_id = params[:user][:group_id].to_i
			@group.group_id = group_id
			if(params[:user][:password]!="")
				@user.update_attributes(password: params[:user][:password])
			end
			if(params[:user][:group_manager]=="1")
				@user.update_attributes(group_manager: true)
	       		@group.manager = true
	   			@group.update_attributes(r: true)
	   			@group.update_attributes(e: true)
	   			@group.update_attributes(d: true)
	   		end
	   		if(params[:user][:group_manager]=="0")
	   			@user.update_attributes(group_manager: false)
	    		@group.manager = false
	    		@group.update_attributes(r: false)
	    		@group.update_attributes(e: false)
	    		@group.update_attributes(d: false)
			end
			
			if !Namegroup.find_by_group_id(group_id).present?
				@group_name = Namegroup.new
				@group_name.group_id = group_id
				@group_name.save
			end
			@user.update_attributes(group_id: group_id)
			flash[:success] = "Completed update"
			redirect_to root_path
		end
		
		if params[:upload].present?
			name = params[:upload][:datafile].original_filename
			directory = 'app/assets/images'
			path = File.join(directory,name)
	    	File.open(path, "wb") { |f| f.write(params[:upload][:datafile].read)}
	    	if @user.update_attributes(avatar_path: name)
			flash[:success] = "Updated avatar"
			sign_in @user
			redirect_to root_path
			else
				flash[:error] = "Error update avatar !"
				sign_in @user
				redirect_to root_path
		    end
    	end
     else
     	redirect_to user_path
     end
	end

	def update_avatar
		@user = User.find(params[:format].to_i)

	end
end
