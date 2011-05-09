class GroupsPlacesController < ApplicationController
  # GET /groups_places
  # GET /groups_places.xml
  def index
    @groups_places = GroupsPlace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups_places }
    end
  end

  # GET /groups_places/1
  # GET /groups_places/1.xml
  def show
    @groups_place = GroupsPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @groups_place }
    end
  end

  # GET /groups_places/new
  # GET /groups_places/new.xml
  def new
    @groups_place = GroupsPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @groups_place }
    end
  end

  # GET /groups_places/1/edit
  def edit
    @groups_place = GroupsPlace.find(params[:id])
  end

  # POST /groups_places
  # POST /groups_places.xml
  def create
    @groups_place = GroupsPlace.new(params[:groups_place])

    respond_to do |format|
      if @groups_place.save
        format.html { redirect_to(@groups_place, :notice => 'Groups place was successfully created.') }
        format.xml  { render :xml => @groups_place, :status => :created, :location => @groups_place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @groups_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups_places/1
  # PUT /groups_places/1.xml
  def update
    @groups_place = GroupsPlace.find(params[:id])

    respond_to do |format|
      if @groups_place.update_attributes(params[:groups_place])
        format.html { redirect_to(@groups_place, :notice => 'Groups place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @groups_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups_places/1
  # DELETE /groups_places/1.xml
  def destroy
    @groups_place = GroupsPlace.find(params[:id])
    @groups_place.destroy

    respond_to do |format|
      format.html { redirect_to(groups_places_url) }
      format.xml  { head :ok }
    end
  end
end
