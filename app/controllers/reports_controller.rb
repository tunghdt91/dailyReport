class ReportsController < ApplicationController

	def new
		@report = Report.new
		@catalogs = Catalog.all

	respond_to do |format|
    	format.html # new.html.erb
      	format.json { render json: @report }
    end
	end

	def create
		name = params[:upload][:datafile].original_filename
		directory = 'public/data'
		path = File.join(directory,name)
	    File.open(path, "wb") { |f| f.write(params[:upload][:datafile].read)}
	    @report = Report.new(params[:report])
	    @report.file_name = name
	    @report.file_path = path
	    if @report.save
	    	# send mail and ....
	    	flash[:success] = "Report Sent !"
	    	redirect_to root_path
	    else
	    	flash[:error] = "Send Error !"
	    end
	end

	def show
	end

	def edit
	end

end
