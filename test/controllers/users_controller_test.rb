require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { address: @user.address, created_user_id: @user.created_user_id, deleted_user_id: @user.deleted_user_id, dob: @user.dob, email: @user.email, name: @user.name, password: @user.password, phone: @user.phone, profile: @user.profile, role: @user.role, updated_user_id: @user.updated_user_id } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { address: @user.address, created_user_id: @user.created_user_id, deleted_user_id: @user.deleted_user_id, dob: @user.dob, email: @user.email, name: @user.name, password: @user.password, phone: @user.phone, profile: @user.profile, role: @user.role, updated_user_id: @user.updated_user_id } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
