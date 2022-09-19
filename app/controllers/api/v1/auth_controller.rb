class Api::V1::AuthController < ApplicationController
  before_action :authenticate, only: %i[logout]

  def sign_up
    @user = User.new(user_params)

    if @user.save
      cookies.encrypted[:token] = {
        value: user.token,
        secure: true,
        expires: 2.weeks.from_now,
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
    cookies.encrypted[:token] = {
      value: user.token,
      secure: true,
      expires: 2.weeks.from_now,
      http_only: true
    }
    cookies.encrypted[:encrypted] = "ajf"
    cookies[:cookie] = "normal!"
    cookies[:option_cookie1] = {
      value: 1,
      secure: true,
      expires: 2.weeks.from_now,
      http_only: true
    }
    cookies[:option_cookie2] = {
      value: 1,
      secure: true,
      http_only: true
    }
    cookies[:option_cookie2] = {
      value: "2",
      secure: true,
      http_only: false
    }
    cookies.permanent[:permanent] = "Jamie"
    cookies.permanent[:option_permanent] = {
      value: 1,
      secure: true,
      expires: 2.weeks.from_now,
      http_only: true
    }
    cookies.permanent[:option_permanent2] = {
      value: 1222,
      expires: 2.weeks.from_now,
      path: "/",
      http_only: true
    }
    cookies.signed[:signed] = 45
    cookies.signed[:option_signed] = {
      value: 1,
      secure: true,
      expires: 2.weeks.from_now,
      http_only: true
    }
    if user&.authenticate(params[:password])
      cookies.encrypted[:token] = {
        value: user.token,
        secure: true,
        expires: 2.weeks.from_now,
        http_only: true
      }
      cookies.encrypted[:encrypted] = "ajf"
      cookies[:cookie] = "normal!"
      cookies[:option_cookie1] = {
        value: 1,
        secure: true,
        expires: 2.weeks.from_now,
        http_only: true
      }
      cookies[:option_cookie2] = {
        value: 1,
        secure: true,
        http_only: true
      }
      cookies[:option_cookie2] = {
        value: "2",
        secure: true,
        http_only: false
      }
      cookies.permanent[:permanent] = "Jamie"
      cookies.permanent[:option_permanent] = {
        value: 1,
        secure: true,
        expires: 2.weeks.from_now,
        http_only: true
      }
      cookies.permanent[:option_permanent2] = {
        value: 1222,
        expires: 2.weeks.from_now,
        path: "/",
        http_only: true
      }
      cookies.signed[:signed] = 45
      cookies.signed[:option_signed] = {
        value: 1,
        secure: true,
        expires: 2.weeks.from_now,
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
    cookies.encrypted[:token] = {
      value: nil,
      secure: true,
      expires: 0.second.from_now,
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