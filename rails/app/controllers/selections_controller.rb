class SelectionsController < ApplicationController
  before_filter :authorize
  # GET /selections
  # GET /selections.xml
  def index
    @selections = Selection.all(:include => {:place => :category})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @selections }
    end
  end

  def current
    date = Date.today
    places = Place.all
    if !places.empty?
      @selection = Selection.first(:conditions => {:date_created => date})
      if @selection.blank?
        @selection = Selection.new(:date_created => date, :place_id => places[rand(places.length)].id)
        @selection.save
      end
      @selection.get_votes
    end
  end
  
  def vote
    @selection = Selection.find(params[:selection_id])
    vote_hash = {:user_id => session[:user_id], :selection_id => @selection.id}
    vote = Vote.first(:conditions => vote_hash)
    vote_hash[:is_up] = params[:vote_value] == 'up'
    if vote.blank?
      vote = Vote.new(vote_hash)
      vote.save
    elsif vote.is_up != vote_hash[:is_up]
      vote.update_attribute(:is_up, vote_hash[:is_up])
      @message = 'Vote changed.'
    else
      @message = 'Voting failed, you already voted!'
    end
    @message ||= 'Voting successful.'
    @selection.get_votes
    respond_to do |format|
      format.js
    end
  end

#  # GET /selections/1
#  # GET /selections/1.xml
#  def show
#    @selection = Selection.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @selection }
#    end
#  end
#
#  # GET /selections/new
#  # GET /selections/new.xml
#  def new
#    @selection = Selection.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @selection }
#    end
#  end
#
#  # GET /selections/1/edit
#  def edit
#    @selection = Selection.find(params[:id])
#  end
#
#  # POST /selections
#  # POST /selections.xml
#  def create
#    @selection = Selection.new(params[:selection])
#
#    respond_to do |format|
#      if @selection.save
#        format.html { redirect_to(@selection, :notice => 'Selection was successfully created.') }
#        format.xml  { render :xml => @selection, :status => :created, :location => @selection }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @selection.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /selections/1
#  # PUT /selections/1.xml
#  def update
#    @selection = Selection.find(params[:id])
#
#    respond_to do |format|
#      if @selection.update_attributes(params[:selection])
#        format.html { redirect_to(@selection, :notice => 'Selection was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @selection.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /selections/1
#  # DELETE /selections/1.xml
#  def destroy
#    @selection = Selection.find(params[:id])
#    @selection.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(selections_url) }
#      format.xml  { head :ok }
#    end
#  end
end
