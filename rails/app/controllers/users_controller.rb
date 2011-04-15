class UsersController < ApplicationController
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:controller => "users", :action => "login") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        session[:user] = user
#        uri = session[:original_uri]
#        session[:original_uri] = nil
#        if uri != nil
#          redirect_to(uri || "/")
#        else
        redirect_to :controller => 'application', :action => 'index', :locale => user.language
#        end
      else
        flash.now[:notice] = "Invalid username/password combination"
      end
    end
  end

  def logout
    locale = session[:user].language
    session[:user_id] = nil
    session[:user] = nil
    flash[:notice] = "Logged out"
    redirect_to :controller => "application", :action => "index", :locale => locale
  end
end
