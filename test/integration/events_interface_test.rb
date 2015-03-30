require 'test_helper'

class EventsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @ngo = ngos(:oxfam)
  end

  test "ngo event interface" do
    log_in_as_ngo(@ngo)

    # Invalid submission
    assert_no_difference 'Event.count' do
      post events_path, event: { 
        
        name:        "",
        start:       "2010-05-30 13:00:00",
        end:         "2015-05-30 14:30:00",
        location:    "London",
        description: "",
        occupancy:   3  
        
      }
    end

    # Valid submission
    assert_difference 'Event.count', 1 do
      post events_path, event: {
        name:        "Serve Dinner at a Homeless Shelter",
        start:       "2015-05-30 13:00:00",
        end:         "2015-05-30 14:30:00",
        location:    "London",
        description: "Volunteering to serve those in need",
        occupancy:   3
      }   
    end
    assert_redirected_to events_path
    follow_redirect!

    # Delete an event.
    assert_select 'a', text: 'delete'
    first_event = @ngo.events.paginate(page: 1).first
    assert_difference 'Eventt.count', -1 do
      delete event_path(first_event)
    end
    # Visit a different ngo.
    get ngo_path(ngos(:water_aid))
    assert_select 'a', text: 'delete', count: 0
  end
end