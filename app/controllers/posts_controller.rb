class PostsController < ApplicationController
  # GET /events/:event_id/posts
  # GET /events/:event_id/posts.xml
  

  def index
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you get all the posts of this event
    @posts = event.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /events/:event_id/posts/:id
  # GET /posts/:id.xml
  def show
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you retrieve the post thanks to params[:id]
    @post = event.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /events/:event_id/posts/new
  # GET /events/:event_id/posts/new.xml
  def new
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you build a new one
    @post = event.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /events/:event_id/posts/:id/edit
  def edit
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you retrieve the post thanks to params[:id]
    @post = event.posts.find(params[:id])
  end

  # POST /events/:event_id/posts
  # POST /events/:event_id/posts.xml
  def create
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you create the post with arguments in post_params
    @post = event.posts.create(post_params)

    respond_to do |format|
      if @post.save
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource post
        format.html { redirect_to([@post.event, @post], :notice => 'Post was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource post
        format.xml  { render :xml => @post, :status => :created, :location => [@post.event, @post] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/:event_id/posts/:id
  # PUT /events/:event_id/posts/:id.xml
  def update
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you retrieve the post thanks to params[:id]
    @post = event.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource post
        format.html { redirect_to([@post.event, @post], :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/:event_id/posts/1
  # DELETE /events/:event_id/posts/1.xml
  def destroy
    #1st you retrieve the event thanks to params[:event_id]
    event = Event.find(params[:event_id])
    #2nd you retrieve the post thanks to params[:id]
    @post = event.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      #1st argument reference the path /events/:event_id/posts/
      format.html { redirect_to(event_posts_url) }
      format.xml  { head :ok }
    end
  end
  


  # private functions
  private
  def post_params
    params.require(:post).permit(:volunteer_id, :event_id, :comment)  
  end
  
  
end










# class PostsController < ApplicationController
#   before_action :set_post, only: [:show, :edit, :update, :destroy]

#   # GET /posts
#   # GET /posts.json
#   def index 
#     if params[:event_id].present?
#       #joins posts to events on event id matching param event_id
#       @posts = Post.joins( :events).where(events: {:id => params[:event_id]} ).order(:created_at)
    
#     else
#     # show all
#     @posts = Post.all
#     end
#   end

#   # GET /posts/1
#   # GET /posts/1.json
#   def show
#   end

#   # GET /posts/new
#   def new
#     @post = Post.new
#   end

#   # GET /posts/1/edit
#   def edit
#   end

#   # POST /posts
#   # POST /posts.json
#   def create
#     @post = Post.new(post_params)

#     respond_to do |format|
#       if @post.save
#         format.html { redirect_to @post, notice: 'Post was successfully created.' }
#         format.json { render :show, status: :created, location: @post }
#       else
#         format.html { render :new }
#         format.json { render json: @post.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /posts/1
#   # PATCH/PUT /posts/1.json
#   def update
#     respond_to do |format|
#       if @post.update(post_params)
#         format.html { redirect_to @post, notice: 'Post was successfully updated.' }
#         format.json { render :show, status: :ok, location: @post }
#       else
#         format.html { render :edit }
#         format.json { render json: @post.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /posts/1
#   # DELETE /posts/1.json
#   def destroy
#     @post.destroy
#     respond_to do |format|
#       format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_post
#       @post = Post.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def post_params
#       params[:post]
#     end
# end
