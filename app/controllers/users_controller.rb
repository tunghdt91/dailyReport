class UsersController < ApplicationController
	include UsersHelper
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
			flash[:errors] = "Errors"
			redirect_to create_new_account_path
		end
	end

	def show
		@user = User.find(params[:id]) || User.find(params[:md5])
		if @user.active
		else
			flash[:error] = "User chua duoc kich hoat"
		end
	end
end
