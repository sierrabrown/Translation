class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Expose these methods to the views
  helper_method :current_user, :signed_in?, :authenticate_user!, :require_signed_out!

  private
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_token(session[:token])
  end
  
  def authenticate_user!(id)
    current_user.id == id
  end
  
  
  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_token!
  end

  def sign_out
    session[:token] = nil
  end

  def require_signed_in!
    redirect_to "/session/new" unless signed_in?
  end
  
  def require_signed_out!
    redirect_to "/#/home" if signed_in?
  end
end
