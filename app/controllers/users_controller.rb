class UsersController < ApplicationController
	include UsersHelper
	#before_filter :checked_admin?, only: [:edit, :all_user]
	

	def create_new_account
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		create_pass_for_user @user
		@user.md5 = Digest::MD5.hexdigest(@user.email)
		if @user.save
			UserMailer.welcome_email(@user).deliver
			UserMailer.mail_to_admin(@user).deliver
			if !@user.active
			flash[:notice] = "Thank You !Your Account is Created.Please wait admin active !"
			end
			sign_in @user
			redirect_to root_path
		else
			flash[:error] = "Email invalid !"
			redirect_to create_new_account_path
		end
	end

	def show
		redirect_to  root_path
		#@user = User.find(params[:id])
		#@microposts = @user.microposts.paginate(page: params[:page])
		
	end

	def all_user
		if  signed_in?
			if current_user.admin?
				@users = User.paginate(page: params[:page])
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

	def update
		@user =  User.find(params[:id].to_i)
		group_id = params[:user][:group_id].to_i
		if(params[:user][:password]!="")
			@user.update_attributes(password: params[:user][:password])
		end
		if(params[:user][:group_manager]=="1")
			@user.update_attributes(group_manager: true)
		end
		@user.update_attributes(group_id: group_id)
		flash[:success] = "Completed update"
		redirect_to root_path
	end
end
