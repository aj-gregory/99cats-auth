module SessionsHelper

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login_user!(user)
    # if current_user = user
#       session[:session_token] = user.session_token
#     else
      session[:session_token] = user.reset_session_token!
    # end
  end

  def logout!
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
  end

  def require_current_user!
    redirect_to new_session_url unless logged_in?
  end

  def require_no_current_user!
    redirect_to cats_url if logged_in?
  end

  def require_current_user_owns_cat!
    redirect_to cats_url if current_user.id != Cat.find(params[:id]).user_id
  end

  def require_current_user_owns_requested_cat!
    redirect_to cats_url if current_user.id != CatRentalRequest.find(params[:id]).cat.user_id
  end

end
