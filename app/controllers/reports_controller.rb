class ReportsController < ApplicationController
	before_filter :activated, only: [:edit, :update, :index]
	def index
	end

	def show
	end

	def create
	end
end
