require "test_helper"

class UserRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_relations_index_url
    assert_response :success
  end
end
