require 'test_helper'

class EventVolunteerTest < ActiveSupport::TestCase
  def setup
    @relationship = EventVolunteer.new(event_id: 1, volunteer_id: 1)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should have an event id" do
    @relationship.event_id = nil
    assert_not @relationship.valid?
  end

  test "should have a volunteer id" do
    @relationship.volunteer_id = nil
    assert_not @relationship.valid?
  end
end
