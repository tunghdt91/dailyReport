module ReportsHelper
	def activated
		current_user.active
	end
end
