class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :add_volunteer]
   before_action :correct_ngo, only: :destroy
  
  #before_action(:set_event, { :only => [:show, :edit, :update, :destroy] })
  #two lines above are the same!!
  
  # GET /events
  # GET /events.json
  def index
    #byebug
      
          
    # http://stackoverflow.com/questions/21590671/handling-multiple-filters-params-cleanly-in-controller
    ###################### needs testing ###########################################
    if params[:tags].present? && params[:location].present? && params[:start].present?
      #joins event table to tags, location, and start matching param tags, location, and start date 
      @events = Event.where( :location => params[:location]).
        where( :start.strftime('%F') => params[:start]).
        joins( :tags).where(tags: {:name => params[:tags]} ).order(:name) 
    
    elsif params[:tags].present? && params[:location].present?
      #joins event table to tags and location matching param tags and location 
      @events = Event.where( :location => params[:location]).
        joins( :tags).where(tags: {:name => params[:tags]} ).order(:start)
      
    elsif params[:start].present? && params[:location].present?
      #event table where location and start matching param location and start date 
      @events = Event.where( :location => params[:location]).
        where( :start.strftime('%F') => params[:start]).order(:name)
      
    elsif params[:tags].present? && params[:start].present?
      #joins event table to tags and start matching param tags and start date 
      @events = Event.where( :start.strftime('%F') => params[:start]).
        joins( :tags).where(tags: {:name => params[:tags]} ).order(:name)
      
      # input year-month-day like: '20015-3-19'
    elsif params[ :start].present?
      #shows all event with start date matching params start
      @events = Event.where( :start.strftime('%F') => params[:start]).order(:name)      
    ###################### needs testing ###########################################
      
      
    elsif params[:tags].present?
      #joins event table to tags (via event_tags) on tag name matching param tags
      @events = Event.joins( :tags).where(tags: {:name => params[:tags]} ).order(:start)

    elsif params[:ngos].present?
      #joins event table to ngos (on ngoid) matching param ngos name
      @events = Event.joins( :ngo).where(ngos: {:name => params[:ngos]} ).order(:start)
      
    elsif params[:location].present?
      #shows all event with location matching params location
      @events = Event.where( :location => params[:location]).order(:start)
      
    else params[:vid].present?
      #joins event table to volunteers (on volid) matching param volunteer id
      @events = Event.joins( :volunteers).where(volunteers: {:volunteer_id => params[:vid]} ).order(:start)    
      
      # needs testing!!! input year-month-day like: '20015-3-19'
    elsif params[:start].present?
      #shows all event with start date matching params start
      @events = Event.where( :start.strftime('%F') => params[:start]).order(:name)
      
    else
      #show all
      @events = Event.paginate(page: params[:page],
        per_page: 10).order(:start)
    end
    
  end


#   SELECT "events".* 
#   FROM "events" 
#   INNER JOIN "event_tags" ON "event_tags"."event_id" = "events"."id" 
#   INNER JOIN "tags" ON "tags"."id" = "event_tags"."tag_id" 
#   WHERE "tags"."name" = 'dog'  
#   ORDER BY "events"."start" ASC
  
  
  def add_volunteer
    event_vol = EventVolunteer.new(create_params)
    event_vol.save()
    event_vol.errors
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start, :end, :location, :description, 
                                    :occupancy, :picture, :avatar)
    end
  
    def correct_ngo
      @event = current_ngo.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
  
end
