class CatalogsController < ApplicationController
	
	 def index
    @catalogs = Catalog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @catalogs }
      format.xls
      format.csv { send_data @catalogs.to_csv }
    end
  end

	def new
		@catalog = Catalog.new
	end

	def edit
		@catalog =  Catalog.find(params[:id])
	end

	def create
	@catalog = Catalog.new(params[:catalog])

    respond_to do |format|
      if @catalog.save
        format.html { redirect_to root_path, notice: 'Category was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @catalog.errors, status: :unprocessable_entity }
      end
    end
	end

	def show
		@catalog = Catalog.find(params[:id])
	end

	def update
		 @catalog = Catalog.find(params[:id])

    respond_to do |format|
      if @catalog.update_attributes(params[:catalog])
        format.html { redirect_to @catalog, notice: 'Catalog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @catalog.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@catalog = Catalog.find(params[:id])
    	@catalog.destroy

    respond_to do |format|
      format.html { redirect_to catalogs_path }
      format.json { head :no_content }
    end
	end
end
