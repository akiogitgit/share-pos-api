class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update destroy destroy_all]

  # GET /posts
  def index
    @posts = Post.all.where(published: true)#.as_json(include: [user: { only: [:username] }])
    @posts2 = Array.new
    @posts.each do |post|
      posts2 = post.as_json
      meta = MetaInspector.new("https://qiita.com/kaito_program/items/27611cff6375edca01f2")
      image = meta.images.best
      # posts2["user"] = post.user
      posts2["user"] = image
      @posts2 << posts2
    end
    render json: {data: @posts2, message: "successfully get posts"},
      status: 200
  end

  # GET /posts/1
  def show
    # published: trueのみ表示
    if @post.published == true || @post.user_id == current_user.id
      render json: {data: @post, message: "successfully get post"},
        status: 200
    else
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
    if @post.user_id != current_user.id
      render json: {message: "更新する権限がありません。"},
        status: 403
      return
    end
    
    if @post.update(post_params)
      render json: {data: @post, message: "successfully update post"},
        status: 200
    else
      render json: {message: @post.errors.full_messages},
        status: 400
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.user_id != current_user.id
      render json: {message: "削除する権限がありません。"},
        status: 403
      return
    end

    if @post.destroy
      render json: {data: @post, message: "投稿を削除しました。"},
        status: 200
    else
      render json: {message: @post.errors.full_messages},
        status: 400
    end
  end

  def destroy_all
    Post.all.each do |post|
      post.destroy
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:comment, :url, :published, :evaluation).merge(user_id: current_user.id)
    end
end
