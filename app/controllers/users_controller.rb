class UsersController < ApplicationController
  before_action :authenticate_user!#, only: %i[show update destroy]

  # mypage アクションを作成して、posts一覧表示とか
  # ユーザー一覧を表示 (まだ必要ない)
  def index
    @users = User.all

    render json: {data: @users, message: "successfully get users"},
      status: 200
  end

  # GET /users/1
  def show
    render json: @user
    
    render json: {data: @user, message: "successfully get user"},
      status: 200
  end

  # POST /users
  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors.full_messages # こっちの方が教えてくれる
  #   end
  # end

  # delete はそのまま v1/authでいけそう
  # update は registration_controller みたいのでカスタム出来ないかな？
  # PATCH/PUT /users/1
  # def update
  #   if current_user.update(user_params)
  #     render json: current_user
  #   else
  #     render json: current_user.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /users/1
  # def destroy
  #   if current_user.destroy
  #     render json: {message: "ユーザーを削除しました。"}
  #   else
  #     render json: {error: "ユーザーを削除に失敗しました。"}
  #   end
  # end

  private

    # Only allow a list of trusted parameters through.
    # def user_params
    #   params.require(:user).permit(:email, :username, :nickname, :password, :password_confirmation)
    # end
end
