class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate, only: %i[index update destroy me]

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

  def show
    posts = @user.posts.order(created_at: :desc)
    posts = posts.where(published: true) if @user != current_user

    # フォローしているか、フォロワー数、フォロー数も返す
    user_info = {id:@user.id ,username: @user.username}
    is_followed = current_user.present? ? current_user.following?(@user) : false
    render json: {data: {
        user: user_info,
        posts: posts,
        is_followed: is_followed,
        following_count: @user.followings.count,
        follower_count: @user.followers.count
      },
      message: "successfully get user"},
    status: 200
  end

  # users/ PUT
  def update
    if current_user.update(user_params)
      render json: {data: non_sensitive_user(current_user), message: "successfully update user"},
        status: 200
    else
      render json: {message: current_user.errors.full_messages},
        status: 400
    end
  end

  # users/ DELETE
  # usernameを「退会済みユーザー」にする
  # destroyに変更
  def destroy
    if current_user.destroy
      render json: {data: non_sensitive_user(current_user), message: "successfully delete user"},
        status: 200
    else
      render json: {message: current_user.errors.full_messages},
        status: 400
    end
  end

  def me
    render json: {data: non_sensitive_user(current_user), message: "successfully get user"},
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

    # token, password を抜いたユーザー
    def non_sensitive_user(user)
      {
        id: user.id,
        username: user.username,
        email: user.email,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end
end
