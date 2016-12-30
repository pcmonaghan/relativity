require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get recieve" do
    get webhooks_recieve_url
    assert_response :success
  end

end
