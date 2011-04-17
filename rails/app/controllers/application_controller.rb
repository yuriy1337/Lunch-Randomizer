class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  
  def authorize
    unless session[:user]
      flash[:notice] = "Please log in"
      redirect_to :controller => "users", :action => "login"
    end
  end

  #Localization support for the app.
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def default_url_options
    { :locale => I18n.locale }
  end

  #Entry view point for the application
  def index

  end

  def get_json(object)
    render :json => object
  end
end
