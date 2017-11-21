class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  /before_action :save_my_previous_url

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
    @back_url = session[:my_previous_url]
  end/
end
