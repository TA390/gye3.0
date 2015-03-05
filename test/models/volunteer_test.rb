require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  
  def setup
    @new_user = Volunteer.new(first_name: "Joe", 
                              last_name: "Bloggs",
                              email: "joebloggs@test.com")
  end

  test "valid database entry" do
    assert @new_user.valid?
  end
  
  test "first_name should be present" do
    @new_user.first_name = ""
    assert_not @new_user.valid?
  end
  
  test "last_name should be present" do
    @new_user.last_name = ""
    assert_not @new_user.valid?
  end
  
  test "email should be present" do
    @new_user.email = ""     
    assert_not @new_user.valid?
  end
  
  test "first name length" do
    assert @new_user.first_name.length < 255
  end
  
  test "last name length" do
    assert @new_user.last_name.length < 255
  end

  test "email length" do
    assert @new_user.email.length < 255
  end
  

end
