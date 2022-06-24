class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  # before_action :authenticate
  # before_action :authenticate_admin!
  before_action :authenticate_user!
  # GET /posts
  def index
    @posts = Post.all

    # render json: @posts
    render json: @posts, status: :ok
  end

  # GET /posts/1
  def show
    render json: @post
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
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
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
