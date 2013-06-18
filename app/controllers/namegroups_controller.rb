class NamegroupsController < ApplicationController
	before_filter :check_admin, only: [:update, :create, :edit]
	def index
		@namegroups = Namegroup.all
	end

	def create
		binding.pry
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

	def update
		@namegroup = Namegroup.find(params[:id])
				if @namegroup.update_attributes(params[:namegroup])
      	  flash[:success] ="Update complete"
      		redirect_to namegroups_path
      	else
      	 	flash[:error] = "UPdate fail"
      	 	redirect_to namegroups_path
      	end
	end

	def edit
		@namegroup = Namegroup.find(params[:id])
	end
	
	def show
		@namegroup = Namegroup.find(params[:id])
	end

end
