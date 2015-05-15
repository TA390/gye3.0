require 'will_paginate/array'
class VolunteersController < ApplicationController
  
  
  before_action :logged_in_user, only: [:edit, :update, :events]
  before_action :correct_user, only: [:edit, :update]
  
  
    
  def index 
    @volunteers = Volunteer.paginate(page: params[:page],per_page: 10).
      order(:name).order(:name)
  end # end def index
  
  
  def search

    # Test PASS
    if params[:volunteer][:name].present? && params[:volunteer][:tags].present? && params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND UPPER(v.location) LIKE UPPER(concat('%', ?, '%'))
        AND date(v.availability) >= (?)
        AND v.gender <= (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:name], params[:volunteer][:location], 
          params[:volunteer][:availability], params[:volunteer][:gender],tag,tag.size])    
    
    # Test PASS
      elsif params[:volunteer][:tags].present? && params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE v.location = (?)
        AND date(v.availability) >= (?)
        AND v.gender <= (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:location],params[:volunteer][:availability], params[:volunteer][:gender],tag,tag.size])

    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:tags].present? && 
      params[:volunteer][:location].present? && params[:volunteer][:availability].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND UPPER(v.location) LIKE UPPER(concat('%', ?, '%'))
        AND date(v.availability) = (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:name], params[:volunteer][:location], params[:volunteer][:availability], tag,tag.size])      
      
    # Test PASS
    elsif params[:volunteer][:tags].present? && params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE v.location = (?)
        AND date(v.availability) = (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:location],params[:volunteer][:availability],tag,tag.size])      
      
    # Test PASS
    elsif params[:volunteer][:name].present? && 
      params[:volunteer][:tags].present? && params[:volunteer][:location].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND UPPER(v.location) LIKE UPPER(concat('%', ?, '%'))
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:name], params[:volunteer][:location], tag, tag.size])
      
    # Test PASS
    elsif params[:volunteer][:tags].present? && params[:volunteer][:location].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE location = (?)
        AND id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY name", 
        params[:volunteer][:location],tag,tag.size])
     
    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        AND UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND UPPER(v.location) LIKE UPPER(concat('%', ?, '%'))
        ORDER BY v.name", 
        params[:volunteer][:availability], params[:volunteer][:gender], params[:volunteer][:name], params[:volunteer][:location]])      
      
    # Test PASS
    elsif params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        AND v.location = (?)
        ORDER BY v.name", 
        params[:volunteer][:availability], params[:volunteer][:gender],params[:volunteer][:location]])

    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:location].present? && 
      params[:volunteer][:availability].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) = (?)
        AND UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND UPPER(v.location) LIKE UPPER(concat('%', ?, '%'))
        ORDER BY v.name", 
        params[:volunteer][:availability],params[:volunteer][:name],params[:volunteer][:location]])    
      
    # Test PASS
    elsif params[:volunteer][:location].present? && params[:volunteer][:availability].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) = (?)
        AND v.location = (?)
        ORDER BY v.name", 
        params[:volunteer][:availability],params[:volunteer][:location]])
     
    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:tags].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        AND UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:availability], params[:volunteer][:gender],params[:volunteer][:name],tag,tag.size])           
      
    # Test PASS
    elsif params[:volunteer][:tags].present? && 
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY v.name", 
        params[:volunteer][:availability], params[:volunteer][:gender],tag,tag.size])      
      

    # Test PASS
    elsif params[:volunteer][:name].present? && 
      params[:volunteer][:tags].present? && params[:volunteer][:availability].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) = (?)
        AND UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
          ORDER BY v.name", 
        params[:volunteer][:availability],params[:volunteer][:name],tag,tag.size])      
      
    # Test PASS
    elsif params[:volunteer][:tags].present? && params[:volunteer][:availability].present?
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) = (?)
        AND v.id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
          ORDER BY v.name", 
        params[:volunteer][:availability],tag,tag.size])

      
    # Test PASS
    elsif params[:volunteer][:name].present? &&
      params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        AND UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        ORDER BY name", 
        params[:volunteer][:availability], params[:volunteer][:gender], params[:volunteer][:name]])      
      
    # Test PASS
    elsif params[:volunteer][:availability].present? && params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE date(v.availability) >= (?)
        AND v.gender <= (?)
        ORDER BY name", 
        params[:volunteer][:availability], params[:volunteer][:gender]])

    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:availability].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND date(v.availability) = (?)
        ORDER BY name", 
        params[:volunteer][:name],params[:volunteer][:availability]])              
      
    # Test PASS
    elsif params[:volunteer][:availability].present?
      @volunteers = Volunteer.where("date(start) = ?", params[:volunteer][:availability]).order(:name)      

    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE UPPER(v.name) LIKE UPPER(concat('%', ?, '%'))
        AND v.gender = (?)
        ORDER BY name", 
        params[:volunteer][:name],params[:volunteer][:gender]])          
      
    # Test PASS
    elsif params[:volunteer][:gender].present?
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers v
        WHERE v.gender = (?)
        ORDER BY name", 
        params[:volunteer][:gender]])    
     
    # Test PASS
    elsif params[:volunteer][:name].present? && params[:volunteer][:tags].present?
      #joins volunteer table to tags (via volunteer_tags) on tag name matching param tags
      #find_by_SQL allows for multiple tag params to be passed in
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE UPPER(name) LIKE UPPER(concat('%', ?, '%'))
        AND id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY name", 
        params[:volunteer][:name],tag,tag.size])
      
    # Test PASS (treating tags as string - spliting values!)
    elsif params[:volunteer][:tags].present?
      #joins volunteer table to tags (via volunteer_tags) on tag name matching param tags
      #find_by_SQL allows for multiple tag params to be passed in
      tag = params[:volunteer][:tags].split
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
          ORDER BY name", 
        tag,tag.size])
      
    # 
    elsif params[:volunteer][:ngos].present?
      #joins volunteer table to ngos (on ngoid) matching param ngos name
      @volunteers = Volunteer.joins( :ngo).where(ngos: {:name => params[:volunteer][:ngos]} ).order(:name)
      
    #  Test PASS
    elsif params[:volunteer][:location].present?
      #shows all volunteer with location matching params location
      @volunteers = Volunteer.where("location ~* ?", "[.]*#{params[:volunteer][:location]}[.]*").order(:name)

    # 
    elsif params[:volunteer][:vid].present?
      #joins volunteer table to volunteers (on volid) matching param volunteer id
      @volunteers = Volunteer.joins( :volunteers).where(volunteers: {:id => params[:volunteer][:vid]} ).order(:name)    
      
    # Test PASS
    elsif params[:volunteer][:name].present?
      #substring matching on volunteer name    
    @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE UPPER(name) LIKE UPPER(concat('%', ?, '%'))
        ORDER BY name",
        params[:volunteer][:name]])
     
    # 
    else
      #show all
      @volunteers = Volunteer.order(:name)
    end
    
    
    if @volunteers.count < 1
      flash[:success] = "Sorry, we did not find any volunteers matching your search criteria"   
    elsif @volunteers.count == 1
      flash[:success] = "We found 1 volunteer based on your search criteria"
    else
      flash[:success] = "We found " + @volunteers.count.to_s + " volunteers based on your search criteria"
    end


    # SET ACTIVATED TO true FOR PRODUCTION
    @volunteers = @volunteers.paginate(page: params[:page],per_page: 10)
    render 'index'
 
  end
      

  
  def show
    @user = Volunteer.find(params[:id])   
    redirect_to root_url and return unless @user
  end
  
  def new
    @user = Volunteer.new
  end
  
  def create
  
    @user = Volunteer.new(user_params)
      
    if @user.save
      @user.send_activation_email
      flash[:notice] = "Please check your email to activate your account"
      redirect_to root_url
      
      #log_in(@user)
      #remember(@user)
      #flash[:success] = "Welcome to your profile"
      #redirect_to @user
    else
      render 'new'
    end
  end
  
  
  def edit
    @user = Volunteer.find(params[:id])
  end
  
  def update
    
    @user = Volunteer.find(params[:id])
    
    dynaspan_text_field(current_user, :name) if logged_in? && current_user?(@user)
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def events
    
    @user = Volunteer.find(params[:id])
    
    # future events
    @title = "Upcoming Events"
    # bookmarked events
    @watch_title = "Watchlist"
    # past events
    @past_title = "Past Events"
    
    #@events = Event.joins(:event_volunteers).where("events.start >= ?", DateTime.now)
    
    @events = @user.events.where(["events.start >= ? and event_volunteers.attending = ?", DateTime.now, "t"]).paginate(page: params[:page], per_page: 10)
    @watch_events = @user.events.where(["events.start >= ? and event_volunteers.attending = ?", DateTime.now, "f"]).paginate(page: params[:page], per_page: 10)
    @past_events = @user.events.where(["events.start < ? and event_volunteers.attending = ?", DateTime.now, "t"]).paginate(page: params[:page], per_page: 10)
  end

  # private functions
  private
  
    def user_params
      params.require(:volunteer).permit(:name, :last_name, :email,
                                        :location, :gender, :password, 
                                        :password_confirmation, :picture,
                                        :avatar)  
    end
  
    # Function to test if a user has logged in
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
  
  # Function to ensure that the profile owner is making the edits / 
  # updates
    def correct_user
      @user = Volunteer.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
end
