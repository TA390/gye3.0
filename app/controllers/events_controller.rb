class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :add_volunteer]
  #before_action(:set_event, { :only => [:show, :edit, :update, :destroy] })
  #two lines above are the same!!
  
  # GET /events
  # GET /events.json
  def index
    #byebug
    
    if params[:tags].present?
     #joins event table to tags (via event_tags) on tag name matching param tags
      @events = Event.joins( :tags).where(tags: {:name => params[:tags]} ).order(:start)

    elsif params[:ngos].present?
      #joins event table to ngos (on ngoid) matching param ngos name
      @events = Event.joins( :ngo).where(ngos: {:name => params[:ngos]} ).order(:start)
      
    elsif params[:location].present?
      #shows all event with location matching params location
      @events = Event.where( :location => params[:location]).order(:start)
      
      # use for volunteer profile page to see which events I am signed up to
    elsif params[:vid].present?
      #joins event table to volunteers (on volid) matching param volunteer id
      @events = Event.joins( :volunteer).where(volunteers: {:volunteer_id => params[:vid]} ).order(:start)      
      
      # needs testing!!! input year-month-day like: '20015-3-19'
    elsif params[ :start].present?
      #shows all event with start date matching params start
      @events = Event.where( :start.strftime('%F') => params[:start]).order(:name)
      
    else
      #show all
      @events = Event.order(:start)
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
  end

  # GET /events/new
  def new
    @event = Event.new
    #@event = @ngo.events.create(event_params)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
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
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start, :end, :location)
    end
end
