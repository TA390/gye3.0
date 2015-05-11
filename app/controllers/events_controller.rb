require 'will_paginate/array'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :add_volunteer]

  before_action :correct_ngo, only: :destroy

  #before_action(:set_event, { :only => [:show, :edit, :update, :destroy] })
  #two lines above are the same!!
  
  #scope for search params
  #has_scope :featured, :type => :boolean
  has_scope :by_tag
  has_scope :by_ngo
  has_scope :by_vol
  has_scope :by_loc
  has_scope :by_period, :using => [:started_at, :ended_at], :type => :hash

  
  
  def index
    # Default is to show all future events (start >= today)
    @events = Event.where("date(start) >= ?", DateTime.now).
      paginate(page: params[:page], per_page: 10).order(:start)
  end # end def index

  
  def search
    # Test PASS!!
    if params[:event][:tags].present? && params[:event][:location].present? && 
      params[:event][:startdate].present? && params[:event][:enddate].present?
      #joins event table to tags, location, and start/end matching param tags, location, and start date and end date
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE e.location = (?)
        AND date(e.start) >= (?)
        AND date(e.end) <= (?)
        AND e.id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY e.start", 
        params[:event][:location],params[:event][:startdate], params[:event][:enddate],tag,tag.size])

    # Test PASS!!
    elsif params[:event][:tags].present? && params[:event][:location].present? && 
      params[:event][:startdate].present?
      #joins event table to tags, location, and start/end matching param tags, location, and start date
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE e.location = (?)
        AND date(e.start) = (?)
        AND e.id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY e.start", 
        params[:event][:location],params[:event][:startdate],tag,tag.size])      
      
    # Test PASS!!
    elsif params[:event][:tags].present? && params[:event][:location].present?
      #joins event table to tags and location matching param tags and location 
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events
        WHERE location = (?)
        AND id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY start", 
        params[:event][:location],tag,tag.size])
      
    # Test PASS!!
    elsif params[:event][:location].present? && 
      params[:event][:startdate].present? && params[:event][:enddate].present?
      #event table where location and start/end matching param location and start date and end date
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.start) >= (?)
        AND date(e.end) <= (?)
        AND e.location = (?)
        ORDER BY e.start", 
        params[:event][:startdate], params[:event][:enddate],params[:event][:location]])
      
    # Test PASS!!
    elsif params[:event][:location].present? && params[:event][:startdate].present?
      #event table where location and start/end matching param location and start date
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.start) = (?)
        AND e.location = (?)
        ORDER BY e.start", 
        params[:event][:startdate],params[:event][:location]])
      
    # Test PASS!!
    elsif params[:event][:tags].present? && 
      params[:event][:startdate].present? && params[:event][:enddate].present?
      #joins event table to tags and start matching param tags and start date and end date
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.start) >= (?)
        AND date(e.end) <= (?)
        AND e.id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY e.start", 
        params[:event][:startdate], params[:event][:enddate],tag,tag.size])      
      
    # Test PASS!!
    elsif params[:event][:tags].present? && params[:event][:startdate].present?
      #joins event table to tags and start matching param tags and start date
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.start) = (?)
        AND e.id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY e.start", 
        params[:event][:startdate],tag,tag.size])
      
    # Test PASS!!
    # input by DateTime (year-month-day) e.g. '2015-03-19' or DateTime.now
    elsif params[:event][:startdate].present? && params[:event][:enddate].present?
      #shows all event with start date matching params start and end
      #end is keyword, need to run query in find_by_sql
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.start) >= (?)
        AND date(e.end) <= (?)
        ORDER BY start", 
        params[:event][:startdate], params[:event][:enddate]])
      
    # Test PASS!!
    elsif params[:event][:startdate].present?
      #shows all event with start date matching params start
      @events = Event.where("date(start) = ?", params[:event][:startdate]).order(:name)      

    # Test PASS!!
    elsif params[:event][:enddate].present?
      #shows all event with end matching params enddate
      #end is keyword, need to run query in find_by_sql
      @events = Event.find_by_sql(
        ["SELECT * FROM events e
        WHERE date(e.end) = (?)
        ORDER BY name", 
        params[:event][:enddate]])    
      
    #
    elsif params[:event][:tags].present? && params[:event][:name].present?
      #joins event table to tags (via event_tags) on tag name matching param tags
      #find_by_SQL allows for multiple tag params to be passed in
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events
        WHERE id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY start", 
        tag,tag.size])
      @events = Event.where("name ~* ?", "[.]*#{params[:event][:name]}[.]*")
      

    # Test PASS!! (treating tags as string - spliting values!)
    elsif params[:event][:tags].present?
      #joins event table to tags (via event_tags) on tag name matching param tags
      #find_by_SQL allows for multiple tag params to be passed in
      tag = params[:event][:tags].split
      @events = Event.find_by_sql(
        ["SELECT * FROM events
        WHERE id IN 
          (SELECT et.event_id 
          FROM event_tags et 
          INNER JOIN tags t ON et.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY et.event_id 
          HAVING COUNT(*) = ?)
        ORDER BY start", 
        tag,tag.size])      
      
      # 
    elsif params[:event][:ngos].present?
      #joins event table to ngos (on ngoid) matching param ngos name
      @events = Event.joins( :ngo).where(ngos: {:name => params[:event][:ngos]} ).order(:start)
      
    #  Test PASS!!
    elsif params[:event][:location].present?
      #shows all event with location matching params location
      @events = Event.where( :location => params[:event][:location]).order(:start)

    # 
    elsif params[:event][:vid].present?
      #joins event table to volunteers (on volid) matching param volunteer id
      @events = Event.joins( :volunteers).where(volunteers: {:id => params[:event][:vid]} ).order(:start)    
      
      
    #  Test PASS!!
    elsif params[:event][:name].present?
      #shows all event with location matching params name
      @events = Event.where("name ~* ?", "[.]*#{params[:event][:name]}[.]*")
      
      
    # Test PASS
    else
      #show all
      @events = Event.all.order(:start) 
      
    end # end if
    
    @events = @events.paginate(page: params[:page], per_page: 10)
    
    render 'index'
  end
  
  def add_volunteer
    event_vol = EventVolunteer.new(create_params)
    event_vol.save()
    event_vol.errors
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @date = @event.start.strftime("%A, %b %d")
    @time = @event.start.strftime("%l:%M %p")
    redirect_to root_url and return unless @event
  end


  # GET /events/new
  def new
    #@event = Event.new
    #@event = @ngo.events.create(event_params)
  end
  
  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    
    @event = current_ngo.events.build(event_params)
    
    if @event.save
      flash[:success] = "Event successfully created!"
      redirect_to events_path
    else
      
      @ngo = current_ngo
      render 'ngos/show'
    end
    
=begin
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, :status => :created, :location => @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    
    flash[:success] = "Event Deleted"
    redirect_to request.referrer || root_url
    
=begin
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
=end
  end
  
  def search_result
    
    @events = Event.where("description ~* ?", "[.]*#{params[:event][:description]}[.]*")
  
  
    search_params = [:start, :created_at]
    search_params.each do |p|
      @events = @events.where("date(#{p}) = ?", params[:event][p]) if params[:event][p].present?
    end
  
    @msg = "We found #{@events.count} event(s) based on your search"
    @events = @events.paginate(page: params[:page], per_page: 10).order(:start)

    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start, :end, :location, :description, 
        :occupancy, :avatar, :video, :cname, :cemail, :street, :address, :postcode,
        :contact, :url)
    end
  
    def correct_ngo
      @event = current_ngo.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
  
end
