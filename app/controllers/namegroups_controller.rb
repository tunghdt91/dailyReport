class NamegroupsController < ApplicationController
	before_filter :check_admin, only: [:setname, :create]
	def setname
		@groups = Group.find_by_sql("select DISTINCT  group_id from groups")
		@namegroup = Namegroup.new
	end

	def create
		if (Namegroup.find_by_group_id(params[:group_id]) == nil)
			@namegroup = Namegroup.new()
			@namegroup.group_id = params[:group_id].to_i
			@namegroup.group_name = params[:namegroup][:group_name]
			
			if @namegroup.save
				flash[:success] = "Change name success"
				redirect_to root_path
			else
				flash[:error] = "Eroor"
				redirect_to root_path
			end
		else
			@namegroup = Namegroup.find_by_group_id(params[:group_id])
				@namegroup.update_attributes(group_id: params[:group_id].to_i)
				@namegroup.update_attributes(group_name: params[:namegroup][:group_name])
			flash[:success] = "Updated name group"
			redirect_to root_path
		end
	end
end
