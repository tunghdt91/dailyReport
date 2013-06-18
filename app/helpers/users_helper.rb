module UsersHelper
	
	# tao mat khau..viet ham rieng.tam thoi mac dinh abcd
	def create_pass_for_user(user)
    s = Digest::MD5.hexdigest(@user.email+"framgia.com")
    passwd = s[0]+s[1]+s[2].upcase+s[3].upcase+s[4]+s[5]
		user.password = passwd
		user.password_confirmation = passwd
  end
  	####### show avatar
  def gravatar_for(user, options = { size: 30 })
    if user.avatar_path
      gravatar_url = user.avatar_path
    else
    gravatar_url = "none.jpg"
    end
    title_img = user.email
    image_tag(gravatar_url, alt: user.email,title: title_img, class: "gravatar", width: "30" ,height: "30",onmouseover: "bigImg(this)", onmouseout: "normalImg(this)")
  end

end
