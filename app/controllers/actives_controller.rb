class ActivesController < ApplicationController
	before_filter :checked_admin?, only: [:index, :show_info_user, :active_user]
	
	#Click link and login .then active user
	# def show
	# 	binding.pry
	# 	@user = User.find_by_md5(params[:id])
	# 	if signed_in? 
	# 		if checked_admin?
	# 			redirect_to show_info_user_path(@user)
	# 		else
	# 			sign_out
	# 			flash[:notice] = "You need login !"
	# 			redirect_to signin_path
	# 		end
	# 	else
	# 		flash[:notice] = "You need login !"
	# 		redirect_to signin_path
	# 	end
	# end

	# one click link to active use
	def show
		@user = User.find_by_md5(params[:id])
		@admin = User.first
		signin_and_active(@admin,@user)

	end


	def show_info_user
		@user = User.find(params[:format])
	end

	def active_user
		@user =  User.find(params[:id].to_i)
		@user.update_attributes(active: true)
		flash[:notice] = "Success ! This account below activated !"
		redirect_to show_info_user_path(@user)
	end
		
end
