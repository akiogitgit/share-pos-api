class Api::V1::AuthController < ApplicationController
  before_action :authenticate, only: %i[logout]

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: {data: @user, message: "successfully create user"},
      status: 200
    else
      render json: {message: @user.errors.full_messages},
        status: 400
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      render json: {data: user, message: "successfully login"},
      status: 200
    else
      if user.present?
        render json: {message: 'パスワードが正しくありません。'},
        status: 400
      else
        render json: {message: 'ユーザーが存在しません。'},
        status: 400
      end
    end
  end

  # 今は使わない
  def logout
    render json: {message: "error"},
    status: 404
  end

  private
    def user_params
      params.permit(:username, :email, :password, :password_confirmation)
    end
end