class AdmincpController < ApplicationController
	def index
	
	end
	def create
		binding.pry
	end

	def restore
		directory = 'db'
	  File.open('db/test_development.sqlite3', "wb") { |f| f.write(params[:datafile].read)}
	  flash[:success] = "restore complete"
		redirect_to admincp_index_path
	end

	def backup
		flash[:notice] = "Dang xay dung !"
		redirect_to admincp_index_path
	end
end
