require "test_helper"

class ForeignKeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @foreign_key = foreign_keys(:one)
  end

  test "should get index" do
    get foreign_keys_url
    assert_response :success
  end

  test "should get new" do
    get new_foreign_key_url
    assert_response :success
  end

  test "should create foreign_key" do
    assert_difference("ForeignKey.count") do
      post foreign_keys_url, params: { foreign_key: {  } }
    end

    assert_redirected_to foreign_key_url(ForeignKey.last)
  end

  test "should show foreign_key" do
    get foreign_key_url(@foreign_key)
    assert_response :success
  end

  test "should get edit" do
    get edit_foreign_key_url(@foreign_key)
    assert_response :success
  end

  test "should update foreign_key" do
    patch foreign_key_url(@foreign_key), params: { foreign_key: {  } }
    assert_redirected_to foreign_key_url(@foreign_key)
  end

  test "should destroy foreign_key" do
    assert_difference("ForeignKey.count", -1) do
      delete foreign_key_url(@foreign_key)
    end

    assert_redirected_to foreign_keys_url
  end
end
