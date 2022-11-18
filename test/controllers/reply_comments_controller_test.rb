require "test_helper"

class ReplyCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply_comment = reply_comments(:one)
  end

  test "should get index" do
    get reply_comments_url, as: :json
    assert_response :success
  end

  test "should create reply_comment" do
    assert_difference("ReplyComment.count") do
      post reply_comments_url, params: { reply_comment: { body: @reply_comment.body, post_id: @reply_comment.post_id, user_id: @reply_comment.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show reply_comment" do
    get reply_comment_url(@reply_comment), as: :json
    assert_response :success
  end

  test "should update reply_comment" do
    patch reply_comment_url(@reply_comment), params: { reply_comment: { body: @reply_comment.body, post_id: @reply_comment.post_id, user_id: @reply_comment.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy reply_comment" do
    assert_difference("ReplyComment.count", -1) do
      delete reply_comment_url(@reply_comment), as: :json
    end

    assert_response :no_content
  end
end
