require "test_helper"

class LayoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get header" do
    get layouts_header_url
    assert_response :success
  end
end
