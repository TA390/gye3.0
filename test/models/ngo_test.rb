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

end
