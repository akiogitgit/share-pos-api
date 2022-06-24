class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  # before_action :authenticate
  before_action :authenticate_user!, only: %i[mypost update destroy]

  # GET /posts
  def index
    @posts = Post.all.where(published: true)

    render json: @posts, status: :ok
  end

  def mypost
    @posts = Post.all.where(user_id: current_user.id)

    render json: @posts, status: :ok
  end

  # GET /posts/1
  def show
    # published: trueのみ表示
    if @post.published == true || @post.user_id == current_user.id
      render json: @post
    else
      render json: {message:"その投稿は表示出来ません。"}
    end
  end

  # POST /posts
  def create
    # paramsに加えて user_id: current_user.id したい
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    # current_user.id == post.user_id なら許可する
    if @post.user_id == current_user.id
      if @post.update(post_params)
        render json: {message:"投稿を更新しました。"}
      else
        render json: @post.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: {message:"更新する権限がありません。"}
    end
  end

  # DELETE /posts/1
  def destroy
    # current_user.id == post.user_id なら許可する
    
    if @post.user_id == current_user.id
      if @post.destroy
        render json: {message:"投稿を削除しました。"}
      else
        render json: @post.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: {message:"削除する権限がありません。"}
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

    # api呼ぶときheadersにtoken入ってないと表示させない
    # def authenticate
    #   authenticate_or_request_with_http_token do |token,options|
    #     auth_user = User.find_by(token: token)
    #     auth_user != nil ? true : false
    #   end
    # end
end
