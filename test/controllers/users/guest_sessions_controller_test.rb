require "test_helper"

class Users::GuestSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_guest_sessions_create_url
    assert_response :success
  end
end
