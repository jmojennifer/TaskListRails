require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "If a user is not logged in they cannot see their task" do
    session[:user_id] = nil  # ensure no one is logged in

    get :show, id: tasks(:sample_task).id
    # if they are not logged in they cannot see the resource and are redirected to login.
    assert_redirected_to root_path
    assert_equal "You must be logged in first", flash[:notice]
  end
end
