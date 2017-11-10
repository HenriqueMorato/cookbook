class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  /before_action :save_my_previous_url

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
    @back_url = session[:my_previous_url]
  end/
end
