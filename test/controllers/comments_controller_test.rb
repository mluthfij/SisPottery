require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get comments_form_url
    assert_response :success
  end

  test "should get comment" do
    get comments_comment_url
    assert_response :success
  end
end
