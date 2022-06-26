class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[mypost create update destroy]

  # GET /posts
  def index
    @posts = Post.all.where(published: true)
    render json: {data: @posts, message: "successfully get posts"},
      status: 200
  end

  def mypost
    @posts = current_user.posts
    render json: {data: @posts, message: "successfully get posts"},
      status: 200
  end

  # GET /posts/1
  def show
    # published: trueのみ表示
    if @post.published == true || @post.user_id == current_user.id
      render json: {data: @posts, message: "successfully get post"},
        status: 200
    else
      # フロントのアラートで表示したいのは、日本語で書く それ以外はRailsに任せる
      render status: 404 # 存在自体を知られたくないから404
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: {data: @post, message: "successfully create post"},
        status: 200
    else
      render json: {message: @post.errors.full_messages},
        status: 400
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.user_id == current_user.id
      if @post.update(post_params)
        render json: {data: @posts, message: "successfully update post"},
          status: 200
      else
        render json: {message: @post.errors.full_messages},
          status: 400
      end
    else
      render json: {message: "更新する権限がありません。"},
        status: 403
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.user_id == current_user.id
      if @post.destroy
        render json: {data: @post, message: "投稿を削除しました。"},
          status: 200
      else
        render json: {message: @post.errors.full_messages},
          status: 400
      end
    else
      render json: {message: "削除する権限がありません。"},
        status: 403
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:comment, :url, :published, :evaluation).merge(user_id: current_user.id)
    end
end
