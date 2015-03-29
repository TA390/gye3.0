require 'test_helper'

class NgoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @ngo = Ngo.new(name: "Oxfam",
                   email: "oxfam@test.com",
                   password: "password",
                   password_confirmation: "password")
  end

  test "ngo should be valid" do
    assert @ngo.valid?
  end
  
  test "ngo user should be present" do
    @ngo.name = "     "
    assert_not @ngo.valid?
  end
  
  test "ngo email should be present" do
    @ngo.email = "     "
    assert_not @ngo.valid?
  end
  
  test "ngo email length" do
    assert @ngo.email.length < 255
  end
  
  test "ngo email addresses should be unique" do
    duplicate_user = @ngo.dup
    duplicate_user.email = @ngo.email.upcase
    @ngo.save
    assert_not duplicate_user.valid?
  end
  
  test "ngo passwords should match" do
    assert (@ngo.password == @ngo.password_confirmation)
  end
  
    # password tests
  test "password should be present" do
    @ngo.password =
      @ngo.password_confirmation = "     "
    assert_not @ngo.valid?
  end
  
  test "password should have a minimum length" do
    @ngo.password = @ngo.password_confirmation = "xxxxx"
      assert_not @ngo.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
      assert_not @ngo.authenticated?(:remember, '')
  end
  
  test "delete events whan an NGO is deleted" do
    @ngo.save
    @ngo.events.create!(
                       name: "Serve Dinner at a Homeless Shelter",
                       start: DateTime.new(2015, 5, 30, 13, 0, 0),
                       end: DateTime.new(2015, 5, 30, 14, 30, 0),
                       location: "London",
                       description: "Become an important member of the community by volunteering to serve those in need",
                       occupancy: 3)
    
    assert_difference 'Event.count', -1 do
      @ngo.destroy
    end
  end

end
