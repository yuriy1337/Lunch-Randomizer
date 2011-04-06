class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize
    unless session[:user]
      flash[:notice] = "Please log in"
      redirect_to :controller => "users", :action => "login"
    end
  end
end
