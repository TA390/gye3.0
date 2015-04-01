require 'test_helper'

class EventVolunteersControllerTest < ActionController::TestCase

  test "to sign up to an event users must be logged in" do
    assert_no_difference 'EventVolunteer.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test "to opt out of an event users must be logged in" do
    assert_no_difference 'EventVolunteer.count' do
      delete :destroy, id: event_volunteers(:one)
    end
    assert_redirected_to login_url
  end
end