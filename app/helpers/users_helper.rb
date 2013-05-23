module UsersHelper
	
	# tao mat khau..viet ham rieng.tam thoi mac dinh abcd
	def create_pass_for_user(user)
		user.password = "abcd"
		user.password_confirmation = "abcd"
  	end
  	####### show avatar
  	def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end
