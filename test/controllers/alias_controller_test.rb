require "test_helper"

class AliasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alias_index_url
    assert_response :success
  end

  test "should get show" do
    get alias_show_url
    assert_response :success
  end

  test "should get new" do
    get alias_new_url
    assert_response :success
  end

  test "should get create" do
    get alias_create_url
    assert_response :success
  end

  test "should get edit" do
    get alias_edit_url
    assert_response :success
  end

  test "should get update" do
    get alias_update_url
    assert_response :success
  end

  test "should get destroy" do
    get alias_destroy_url
    assert_response :success
  end
end
