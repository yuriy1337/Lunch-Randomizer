class GroupsUsersController < ApplicationController
  # GET /groups_users
  # GET /groups_users.xml
  def index
    @groups_users = GroupsUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups_users }
    end
  end

  # GET /groups_users/1
  # GET /groups_users/1.xml
  def show
    @groups_user = GroupsUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @groups_user }
    end
  end

  # GET /groups_users/new
  # GET /groups_users/new.xml
  def new
    @groups_user = GroupsUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @groups_user }
    end
  end

  # GET /groups_users/1/edit
  def edit
    @groups_user = GroupsUser.find(params[:id])
  end

  # POST /groups_users
  # POST /groups_users.xml
  def create
    @groups_user = GroupsUser.new(params[:groups_user])

    respond_to do |format|
      if @groups_user.save
        format.html { redirect_to(@groups_user, :notice => 'Groups user was successfully created.') }
        format.xml  { render :xml => @groups_user, :status => :created, :location => @groups_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @groups_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups_users/1
  # PUT /groups_users/1.xml
  def update
    @groups_user = GroupsUser.find(params[:id])

    respond_to do |format|
      if @groups_user.update_attributes(params[:groups_user])
        format.html { redirect_to(@groups_user, :notice => 'Groups user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @groups_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups_users/1
  # DELETE /groups_users/1.xml
  def destroy
    @groups_user = GroupsUser.find(params[:id])
    @groups_user.destroy

    respond_to do |format|
      format.html { redirect_to(groups_users_url) }
      format.xml  { head :ok }
    end
  end
end
