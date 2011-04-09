class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  
  def authorize
    unless session[:user]
      flash[:notice] = "Please log in"
      redirect_to :controller => "users", :action => "login"
    end
  end

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def index

  end
end
