module SessionsHelper

  def active?
    current_user.active
  end

  def activation_in_user
    unless active?
      store_location
      redirect_to root_path, notice: "Permission Access. Your Account not active."
    end
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    
  end

  def signin_and_active(user,admin)
    sign_in admin
    redirect_to show_info_user_path(@user)   
  end

  def current_user=(user)
    @current_user = user
  end

  def current_product=(product)
    @current_product= product
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user? user
    user == current_user
  end

  def checked_admin?
    current_user.admin
  end

  def signed_in?
    !current_user.nil?
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def check_admin
    unless signed_in? && current_user.admin?
      flash[:errors] = "Only administrator can use it !"
     redirect_to root_url  
    
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default )
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def activated
   
    if !current_user.nil? && current_user.active 
    else
      flash[:notice] = "Permission Access ! Contact to Admin"
      redirect_to root_path
    end
  end

  def checked_manager
    unless signed_in? && current_user.group_manager?
      flash[:errors] = "You not manager group !"
     redirect_to root_path
    
    end
  end

  def checked_read
    unless signed_in? && (Group.find_by_user_id(current_user.id).r? || current_user.admin?)
      flash[:errors] = "You Not Permission Read this Pages."
     redirect_to root_path
    
    end
  end

  def fix_date(year,month,day)
    if day<10 && month<10
      result = year.to_s + '-0' + month.to_s + '-0' + day.to_s 
    end

    if day<10 && month>9
      result = year.to_s + '-' + month.to_s + '-0' + day.to_s 
    end
    if day>9 && month<10
      result = year.to_s + '-0' + month.to_s + '-' + day.to_s 
    end
    return result
  end

end
