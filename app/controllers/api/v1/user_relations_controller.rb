class Api::V1::UserRelationsController < ApplicationController
  before_action :set_followed_user
  # before_action :authenticate

  # フォローする
  def create
    # 既にフォローしている場合
    if current_user.following?(@followed_user)
      render json: {message: "既にユーザーをフォローしています"},
        status: 400
      return
    end

    if current_user.follow(@followed_user.id)
      @user = {id: @followed_user.id, username: @followed_user.username}
      render json: {data: @user, message: "successfully follow"},
        status: 200
    else
      render json: {message: "フォローに失敗しました"},
        status: 400
    end
  end

  # フォロー解除
  def destroy
    # まだフォローしていない
    if !current_user.following?(@followed_user)
      render json: {message: "このユーザーをフォローしていません"},
        status: 400
      return
    end

    if current_user.unfollow(@followed_user.id)
      @user = {id: @followed_user.id, username: @followed_user.username}
      render json: {data: @user, message: "successfully unfollow"},
        status: 200
    else
      render json: {message: "フォロー解除に失敗しました"},
        status: 400
    end
  end

  # フォロウィング一覧
  def followings
    render json: {data: @followed_user.followings, message: "successfully get followings"},
      status: 200
  end

  # フォロワー一覧
  def followers
    render json: {data: @followed_user.followers, message: "successfully get followers"},
      status: 200
  end

  private

  def set_followed_user
    # parmasのuserが存在しない
    if !User.exists?(params[:user_id])
      render json: {message: "ユーザーが存在しません"},
        status: 404
      return
    end

    @followed_user = User.find(params[:user_id])
  end
  
end
