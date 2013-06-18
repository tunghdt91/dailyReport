class ReportsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new, :filter_month, :index]
	before_filter :activation_in_user, only: [:new]

	def new
		@report = Report.new
		@catalogs = Catalog.all
	end

	def export_user
		respond_to do |format|
			format.xls
		end
	end

	def export_group
		respond_to do |format|
			format.xls
		end
	end

	def index
		
		if(params[:q].nil?)
				@search = Report.search(params[:q])
				@reports = @search.result
				@users =@reports.pluck('user_id').uniq
    		@search.build_condition if @search.conditions.empty?
    		@search.build_sort if @search.sorts.empty?	
		else
				if(params[:q][:created_at_lteq]=="")
					params[:q][:created_at_lteq]=(Date.parse(params[:q][:created_at_gteq])+24.hour).to_s
				end
				params[:q][:group_id_eq] = current_user.group_id
				@search = Report.search(params[:q])
				@reports = @search.result
				@users =@reports.pluck('user_id').uniq
    		@search.build_condition if @search.conditions.empty?
    		@search.build_sort if @search.sorts.empty?
    end
	end

	def filter_month
		if(params[:q].nil?)	
			@search = Report.search(params[:q])
			@reports = @search.result
			@catalogs =@reports.pluck('catalog_id').uniq
			@week1=[]
			@week2=[]
			@week3=[]
			@week4=[]
			@week5=[]
			@time_start=Date.today
			@time_end=Date.today+24.hours
			@users=User.where('group_id=?',current_user.group_id)
    	@search.build_condition if @search.conditions.empty?
    	@search.build_sort if @search.sorts.empty?
    else

    	@time_start= params[:year]+"-"+params[:q][:created_at_gteq]+"-01 00:00:00 UTC"
    	@time_end = Date.parse(@time_start).at_end_of_month.to_s+" 23:59:59 UTC"
    	params[:q][:created_at_gteq]=@time_start
    	params[:q][:created_at_lteq]=@time_end
    	params[:q][:group_id_eq]=current_user.group_id
    	@search = Report.search(params[:q])
			@reports = @search.result
			@users =@reports.pluck('user_id').uniq
			@catalogs =@reports.pluck('catalog_id').uniq
    	@search.build_condition if @search.conditions.empty?
    	@search.build_sort if @search.sorts.empty?

    	
    	# search week1
    	params[:q][:created_at_gteq]=@time_start
    	params[:q][:created_at_lteq]=(Date.parse(@time_start).next_week+24.hours).to_s
    	params[:q][:group_id_eq]=current_user.group_id
    	@search1=Report.search(params[:q])
    	@week1=@search1.result
    	
    	# week2
    	params[:q][:created_at_gteq]=(Date.parse(@time_start).next_week+24.hours).to_s
    	params[:q][:created_at_lteq]=(Date.parse(@time_start).next_week.next_week+24.hours).to_s
    	params[:q][:group_id_eq]=current_user.group_id
    	@search2=Report.search(params[:q])
    	@week2=@search2.result
    	# week3
    	params[:q][:created_at_gteq]=(Date.parse(@time_start).next_week.next_week+24.hours).to_s
    	params[:q][:created_at_lteq]=(Date.parse(@time_start).next_week.next_week.next_week+24.hours).to_s
    	params[:q][:group_id_eq]=current_user.group_id
    	@search3=Report.search(params[:q])
    	@week3=@search3.result
    	# week4
    	params[:q][:created_at_gteq]=(Date.parse(@time_start).next_week.next_week.next_week+24.hours).to_s
    	params[:q][:created_at_lteq]=(Date.parse(@time_start).next_week.next_week.next_week.next_week+24.hours).to_s
    	params[:q][:group_id_eq]=current_user.group_id
    	@search4=Report.search(params[:q])
    	@week4=@search4.result
    	# week5
    	params[:q][:created_at_gteq]=(Date.parse(@time_start).next_week.next_week.next_week.next_week+24.hours).to_s
    	params[:q][:created_at_lteq]=(Date.parse(@time_start).at_end_of_month+24.hours).to_s
    	params[:q][:group_id_eq]=current_user.group_id
    	@search5=Report.search(params[:q])
    	@week5=@search5.result
    end	
	end

	def get_name
		respond_to do |format|
			format.json { render json: Catalog.find(params[:id]).detail.to_json }
	end
		
	end

	def create
		@report = Report.new(params[:report])
		if params[:datafile].present?
			name = params[:datafile].original_filename
			directory = 'public/data'
			path = File.join(directory,name)
	    	File.open(path, "wb") { |f| f.write(params[:datafile].read)}
	    	@report.file_name = name
	    	@report.file_path = path	
		end
			@report.group_id = current_user.group_id
	    @report.user_id = current_user.id
	    if @report.save
	    	# send mail and ....
	    	flash[:success] = "Report Sent !"
	    	redirect_to root_path
	    else
	    	render 'new'
	    end
	end

	def show
	end

	def edit
	end

	def send_report_to_group
		@user = User.find(params[:id])
		
	end

end
