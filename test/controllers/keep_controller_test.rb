require "test_helper"

class KeepControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get keep_show_url
    assert_response :success
  end
end
