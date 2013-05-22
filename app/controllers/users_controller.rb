class UsersController < ApplicationController
	include UsersHelper
	def create_new_account
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		create_pass_for_user @user
		if @user.save
			UserMailer.welcome_email(@user).deliver
			flash[:success] = "Thank You !\nYour Account is Created."
			redirect_to root_path
		else
			flash[:errors] = "Errors"
			redirect_to create_new_account_path
		end
	end
end
