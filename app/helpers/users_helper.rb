module UsersHelper
	def create_pass_for_user(user)
		user.password = "abcd"
		user.password_confirmation = "abcd"
  end
end
