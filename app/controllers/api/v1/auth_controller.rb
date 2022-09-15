class Api::V1::AuthController < ApplicationController
  before_action :authenticate, only: %i[logout]

  def sign_up
    @user = User.new(user_params)

    if @user.save
      cookies.encrypted[:user_id] = {
        value: user.id,
        secure: true,
        expires: 3.minute.from_now,
        http_only: true
      }

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
      cookies.encrypted[:user_id] = {
        value: user.id,
        secure: true,
        expires: 3.minute.from_now,
        http_only: true
      }

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

  def logout
    cookies.encrypted[:user_id] = {
      value: nil,
      secure: true,
      expires: 1.second.from_now,
      http_only: true
    }
    render json: {message: "successfully logout"},
    status: 200
  end

  private
    def user_params
      params.permit(:username, :email, :password, :password_confirmation)
    end
end