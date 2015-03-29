require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
    
    @ngo = ngos(:oxfam)
    # This code is not idiomatically correct.

    @event = @ngo.events.build(
                       name: "Serve Dinner at a Homeless Shelter",
                       start: DateTime.new(2015, 5, 30, 13, 0, 0),
                       end: DateTime.new(2015, 5, 30, 14, 30, 0),
                       location: "London",
                       description: "Become an important member of the community by volunteering to serve those in need",
                       occupancy: 3)
    
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "user id should be present" do
    @event.ngo_id = nil
    assert_not @event.valid?
  end
  
  test "must provide a description" do
    @event.description = "   "
    assert_not @event.valid?
  end

  test "description must be <= 1000 characters" do
    @event.description = "a" * 1001
    assert_not @event.valid?
  end
  
  test "retrieve events reverse order (most recent first)" do
    assert_equal Event.first, events(:homeless)
  end
 
end
