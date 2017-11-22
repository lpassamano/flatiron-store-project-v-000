class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_cart

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || store_path
  end

  def current_cart
    current_user.current_cart
  end
end
