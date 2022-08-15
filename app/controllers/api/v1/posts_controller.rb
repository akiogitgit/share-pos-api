class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate, only: %i[create update destroy delete_all]

  def index
    @posts = Post.where(published: true)
    render json: {data: @posts, message: "successfully get posts"},
      status: 200
  end

  def show
    # published: trueのみ表示
    if @post.published == true || current_user && @post.user_id == current_user.id
      render json: {data: @post, message: "successfully get post"},
        status: 200
    else
      render status: 404 # 存在自体を知られたくないから404
    end
  end

  def create
    @post = Post.new(post_params)
    meta = MetaInspector.new(@post.url)

    # meta情報も追加する
    if @post.save && meta.present?
      title = meta.title || ""
      image = meta.images.best || ""
      MetaInfo.create({post_id:@post.id, image:image, title:title})

      render json: {data: @post, message: "successfully create post and meta_info"},
        status: 200
    else
      render json: {message: @post.errors.full_messages},
        status: 400
      return
    end
  end

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
