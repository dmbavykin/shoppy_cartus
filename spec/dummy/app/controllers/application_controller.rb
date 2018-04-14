class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= ShoppyCartus.user_class.constantize.find_by(id: session[:user_id])
  end
end
