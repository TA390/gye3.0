require 'test_helper'

class WatchlistTest < ActiveSupport::TestCase

  def setup
    @bookmark = Watchlist.new(event_id: 1, volunteer_id: 1)
  end

  test "valid entry" do
    assert @bookmark.valid?
  end

  test "event id must be present" do
    @bookmark.ebent_id = nil
    assert_not @bookmark.valid?
  end

  test "volunteer id must be present" do
    @bookmark.volunteer_id = nil
    assert_not @bookmark.valid?
  end
  
  
end