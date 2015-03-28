require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  
  def setup
  
    @new_user = 
      Volunteer.new(name: "Joe", 
                    last_name: "Bloggs",
                    gender: "M",
                    location: "London, UK",
                    email: "joe_bloggs@test.com",
                    password: "secure",
                    password_confirmation: "secure")
  end

  # test that the entry is valid
  test "valid database entry" do
    assert @new_user.valid?
  end
  # end test
  
  # test that the fields are not empty
  test "name should be present" do
    @new_user.name = "     "
    assert_not @new_user.valid?
  end
  
    test "last_name should be present" do
    @new_user.last_name = "     "
    assert_not @new_user.valid?
  end
  
  test "email should be present" do
    @new_user.email = "     "     
    assert_not @new_user.valid?
  end
  
  test "gender should be present" do
    @new_user.gender = "     "     
    assert_not @new_user.valid?
  end
  
  test "location should be present" do
    @new_user.location = "     "     
    assert_not @new_user.valid?
  end
  # end test
  
  # test the length of input fields
    test "first name length" do
    assert @new_user.name.length < 255
  end
  
  test "last name length" do
    assert @new_user.last_name.length < 255
  end

  test "email length" do
    assert @new_user.email.length < 255
  end
  # end test
  
  # test that the email address entered is unqiue
  # FoO@tEsT.cOm is equal to foo@test.com
  test "email addresses should be unique" do
    duplicate_user = @new_user.dup
    duplicate_user.email = @new_user.email.upcase
    @new_user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lowercase" do
    mixed_case_email = "JoE_bLoGgS@tEsT.cOm"
    @new_user.email = mixed_case_email
    @new_user.save
    assert_equal mixed_case_email.downcase,
      @new_user.reload.email
  end
  # end test
  
  # password tests
  test "password should be present" do
    @new_user.password =
      @new_user.password_confirmation = "     "
    assert @new_user.valid?
  end
  
  test "password should have a minimum length" do
    @new_user.password = 
      @new_user.password_confirmation = "xxxxx"
      assert_not @new_user.valid?
  end
  
  test "passwords should match" do
    assert (@new_user.password == @new_user.password_confirmation)
  end
  # end password 
  
  test "authenticated? - return false for users will nil digest" do
      assert_not @new_user.authenticated?(:remember, '')
  end
  
end
