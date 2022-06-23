class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors.full_messages # こっちの方が教えてくれる
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if current_user.destroy
      render json: {message: "ユーザーを削除しました。"}
    else
      render json: {error: "ユーザーを削除に失敗しました。"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = Post.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :username, :nickname, :password)
    end
end
