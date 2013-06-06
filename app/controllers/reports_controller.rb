class ReportsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new]
	before_filter :activation_in_user, only: [:new]

	def new
		@report = Report.new
		@catalogs = Catalog.all

	respond_to do |format|
    	format.html # new.html.erb
      	format.json { render json: @report }
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
