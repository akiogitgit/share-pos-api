class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate

  # ユーザー一覧を表示 (名前だけでいい)
  def index
    @users = User.all.order(created_at: :desc).map do |user|
      {
        id: user.id,
        username: user.username
      }
    end

    render json: {data: @users, message: "successfully get users"},
      status: 200
  end

  # 今後フォロー機能や、他のユーザーの投稿を個別で見る時に使う
  def show
    posts = @user.posts
    posts = posts.where(published: true) if @user != current_user

    render json: {data: {user: {id:@user.id ,username: @user.username}, posts: posts}, message: "successfully get user"},
      status: 200
  end

  # users/ PUT
  def update
    if current_user.update(user_params)
      render json: {data: current_user, message: "successfully update user"},
        status: 200
    else
      render json: {message: current_user.errors.full_messages},
        status: 400
    end
  end

  # users/ DELETE
  # usernameを「退会済みユーザー」にする
  def delete
    if current_user.destroy
      render json: {data: current_user, message: "successfully delete user"},
        status: 200
    else
      render json: {message: current_user.errors.full_messages},
        status: 400
    end
  end

  def me
    render json: {data: current_user, message: "successfully get user"},
      status: 200
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # passwordの変更はさせない
    def user_params
      params.permit(:username, :email)
    end
end
