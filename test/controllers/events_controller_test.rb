require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  
  def setup
    @event = events(:homeless)
  end
  
  # Events Page
  test "should get events" do
    get :index
    assert_response :success
    assert_select "title", "Events"
  end
  
  test "prevent 'create' if not logged in" do
    assert_no_difference 'Event.count' do
      post :create, event: { 
        name: "Serve Dinner at a Homeless Shelter",
        start: DateTime.new(2015, 5, 30, 13, 0, 0),
        end: DateTime.new(2015, 5, 30, 14, 30, 0),
        location: "London", 
        description: "Become an important member of the community by volunteering to serve those in need",
        occupancy: 3 
      }
    end
    assert_redirected_to login_url
  end

  test "prevent 'destroy' if not logged in" do
    assert_no_difference 'Event.count' do
      delete :destroy, id: @event
    end
    assert_redirected_to login_url
  end
  
  test "prevent an ngo delete events of another ngo" do
    log_in_as_ngo(ngos(:oxfam))
    event = events(:homeless)
    assert_no_difference 'Event.count' do
      delete :destroy, id: event
    end
    assert_redirected_to root_url
  end
  
=begin
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
=end
end
