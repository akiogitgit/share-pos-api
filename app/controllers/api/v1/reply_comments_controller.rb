class Api::V1::ReplyCommentsController < ApplicationController
  before_action :set_reply_comment, only: %i[ show update destroy ]
  before_action :authenticate, only: %i[create update destroy]
  
  # create update deleteだけでいい。
  # 表示するのは、postに含める

  def index
    # ReplyComment.create({user_id: User.first.id, post_id: Post.first.id, body: "コメントです"})
    @reply_comments = ReplyComment.all

    render json: {data: @reply_comments, message: "successfully get comments"},
        status: 200
  end

  # def show
  #   render json: @reply_comment
  # end

  def create
    @reply_comment = ReplyComment.new(reply_comment_params)

    if @reply_comment.save
      render json: {data: @reply_comment, message: "successfully create comment"},
      status: 200
    else
      render json: {message: @reply_comment.errors.full_messages},
        status: 400
    end
  end

  # update, delete を自分のコメントだけ許可する
  def update
    if @reply_comment.update(reply_comment_params)
      render json: {data: @reply_comment, message: "successfully update comment"},
      status: 200
    else
      render json: {message: @reply_comment.errors.full_messages},
      status: 400
    end
  end

  def destroy
    if @reply_comment.destroy
      render json: {data: @reply_comment, message: "コメントを削除しました。"},
        status: 200
    else
      render json: {message: @reply_comment.errors.full_messages},
        status: 400
    end
  end

  private
    def set_reply_comment
      @reply_comment = ReplyComment.find(params[:id])
    end

    def reply_comment_params
      params.require(:reply_comment).permit(:user_id, :post_id, :body)
    end
end
