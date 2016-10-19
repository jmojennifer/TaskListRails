require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "Authenticate a user with all data" do
    user = User.new(name: "Testing McTester", email: "tests@realgood.com", uid: 23456, provider: "github")
    assert user.valid?
  end

  test "Create a user with just all required data" do
    user = User.new(uid: 34756, provider: "github")
    assert user.valid?
  end

  test "Cannot create a movie with only unrequired data" do
    user = User.new(name: "Will Jones", email: "wjones@test.com")
    assert_not user.valid?
  end

  #TODO: Add tests related to creating a user via auth_hash for def self.build_from_github(auth_hash)  

end
