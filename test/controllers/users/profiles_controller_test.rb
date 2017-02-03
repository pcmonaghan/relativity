require 'test_helper'

class Users::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_profiles_show_url
    assert_response :success
  end

end
