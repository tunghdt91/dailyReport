module UsersHelper
	
	# tao mat khau..viet ham rieng.tam thoi mac dinh abcd
	def create_pass_for_user(user)
    s = Digest::MD5.hexdigest(@user.email+"framgia.com")
    passwd = s[0]+s[1]+s[2].upcase+s[3].upcase+s[4]+s[5]
		user.password = passwd
		user.password_confirmation = passwd
  	end
  	####### show avatar
  	def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end
