class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :authenticate, only: %i[create update destroy]

  # create update deleteだけでいい。
  # 表示するのは、postに含める

  def index
    # Comment.create({user_id: User.first.id, post_id: Post.first.id, text: "コメントです"})
    @comments = Comment.all

    # render json: @comments
    render json: {data: @comments, message: "successfully get comments"},
        status: 200
  end

  # def show
  #   render json: @comment
  # end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      # render json: @comment, status: :created, location: @comment
      render json: {data: @comment, message: "successfully create comment"},
      status: 200
    else
      # render json: @comment.errors, status: :unprocessable_entity
      render json: {message: @comment.errors.full_messages},
        status: 400
    end
  end

  # update, delete を自分のコメントだけ許可する
  def update
    if @comment.update(comment_params)
      render json: {data: @comment, message: "successfully update comment"},
      status: 200
    else
      render json: {message: @comment.errors.full_messages},
      status: 400
    end
  end

  def destroy
    if @comment.destroy
      render json: {data: @comment, message: "コメントを削除しました。"},
        status: 200
    else
      render json: {message: @comment.errors.full_messages},
        status: 400
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.fetch(:comment, {})
    end
end
