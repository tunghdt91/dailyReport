class GroupsController < ApplicationController
	before_filter :checked_manager, only: [:set_role, :update]
	before_filter :checked_read, only: [:group_report]

	def index
		@search = Report.search(params[:q])
		@reports = @search.result
    	@search.build_condition if @search.conditions.empty?
    	@search.build_sort if @search.sorts.empty?
	end

	def get_group_name
		respond_to do |format|
			format.json { render json: Namegroup.find_by_group_id(params[:id]).group_name.to_json }
		end
	end

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


	def group_report
			if(current_user.group_id.nil?)
				flash[:error] = "You Not in any group ! Please contact to admin"
				redirect_to root_path
			else
				@users = User.find_by_sql("SELECT * FROM users  WHERE group_id = #{current_user.group_id}") ## all user in group	
			end
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

	def find_report_user
		if params[:user][:email] == "" || params[:find_year]=="" || params[:find_month]==""
			flash[:error] = " Filter user |Need select user or choose year and choose month!"
			redirect_to group_report_path
		else # da chon user va nam
			if check_input_form_user(params[:find_year],params[:find_month])
				if params[:find_day]!=""
					if 0<params[:find_day].to_i && params[:find_day].to_i<32 # du lieu nhap vao chinh xac  yyyy-mmm-dd
						@find_user_id = params[:user][:email].to_i
						@find_day = params[:find_day].to_i
						@find_month = params[:find_month].to_i
						@find_year = params[:find_year].to_i

						time_open = fix_date(@find_year,@find_month,@find_day)
						tmp= DateTime.parse(time_open) + 24.hour
						time_close = fix_date(tmp.year,tmp.month,tmp.day)
						
					else
						flash[:error] = "Filter user |Input date invalid! "
						redirect_to group_report_path
					end
				else # du lieu nhap vao chinh xac yyyy-mm
					@find_user_id = params[:user][:email].to_i
					@find_month = params[:find_month].to_i
					@find_year = params[:find_year].to_i
					time_open = fix_date(@find_year,@find_month,1)
					time_close = fix_date(@find_year,@find_month,31)
				end	
				query = "select DISTINCT  catalog_id from reports where user_id=#{@find_user_id} and created_at between '#{time_open}' and '#{time_close}'"
				@catalogs =Report.find_by_sql(query)
				query2 = "select * from reports where user_id=#{@find_user_id} and created_at between '#{time_open}' and '#{time_close}'"
				@reports = Report.find_by_sql(query2)
			else
				flash[:error] = "Filter user |Data input invalid"
				redirect_to root_path
			end
			
		end
	end


	def find_report_group
		if params[:find_year]=="" || params[:find_month]==""
			flash[:error] = "Filter group |Must choose year and choose month!"
			redirect_to group_report_path
		else # da chon user va nam
			if check_input_form_user(params[:find_year],params[:find_month])
				if params[:find_day]!=""
					if 0<params[:find_day].to_i && params[:find_day].to_i<32 # du lieu nhap vao chinh xac  yyyy-mmm-dd
						@find_day = params[:find_day].to_i
						@find_month = params[:find_month].to_i
						@find_year = params[:find_year].to_i

						@time_open = fix_date(@find_year,@find_month,@find_day)
						tmp= DateTime.parse(@time_open) + 24.hour
						@time_close = fix_date(tmp.year,tmp.month,tmp.day)
					else
						flash[:error] = "Filter Group |Input day invalid! "
						redirect_to group_report_path
					end	
				else # du lieu nhap vao chinh xac yyyy-mm
					@find_month = params[:find_month].to_i
					@find_year = params[:find_year].to_i
					@time_open = fix_date(@find_year,@find_month,1)
					@time_close = fix_date(@find_year,@find_month,31)
				end
				@users = User.find_by_sql("SELECT * FROM groups  WHERE group_id = #{current_user.group_id}") ## all user in group
				tmp = (@users.count - 1) # if co report cua nhom nay
				
				if(tmp==0)
					str = @users[0].user_id.to_s
				else
					str=@users[0].user_id.to_s
					for i in 1..tmp
						str = str+','+@users[i].user_id.to_s
					end
				end
				str = '(' + str + ')'

				query = "select DISTINCT  catalog_id from reports where created_at between '#{@time_open}' and '#{@time_close}' and user_id IN #{str}"
				@catalogs =Report.find_by_sql(query)
			else
				flash[:error] = "Filter Group |Data input invalid"
				redirect_to group_report_path
			end
		end
	end
end
