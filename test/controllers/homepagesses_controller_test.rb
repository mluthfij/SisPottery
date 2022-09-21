require "test_helper"

class HomepagessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @homepagess = homepagesses(:one)
  end

  test "should get index" do
    get homepagesses_url
    assert_response :success
  end

  test "should get new" do
    get new_homepagess_url
    assert_response :success
  end

  test "should create homepagess" do
    assert_difference('Homepagess.count') do
      post homepagesses_url, params: { homepagess: { brand_name: @homepagess.brand_name, description: @homepagess.description, title: @homepagess.title } }
    end

    assert_redirected_to homepagess_url(Homepagess.last)
  end

  test "should show homepagess" do
    get homepagess_url(@homepagess)
    assert_response :success
  end

  test "should get edit" do
    get edit_homepagess_url(@homepagess)
    assert_response :success
  end

  test "should update homepagess" do
    patch homepagess_url(@homepagess), params: { homepagess: { brand_name: @homepagess.brand_name, description: @homepagess.description, title: @homepagess.title } }
    assert_redirected_to homepagess_url(@homepagess)
  end

  test "should destroy homepagess" do
    assert_difference('Homepagess.count', -1) do
      delete homepagess_url(@homepagess)
    end

    assert_redirected_to homepagesses_url
  end
end
