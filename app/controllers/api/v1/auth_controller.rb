class Api::V1::AuthController < ApplicationController

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
      # payload = { message: 'ログインしました。', token: user.token }
      render json: {data: {token: user.token}, message: "successfully login"},
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

  private
    def user_params
      params.permit(:username, :email, :password, :password_confirmation)
    end
end

# def login
#   user = User.find_by(username: params[:session][:username])
#   if user&.authenticate(params[:session][:password])
#     payload = { message: 'ログインしました。', token: user.token }
#     # render plain: user.token
#   else
#     if user.present?
#       payload = { errors: ['パスワードが正しくありません。'] }
#     else
#       payload = { errors: ['メールアドレスが存在しません。'] }
#     end
#   end
#   # render json: payload
#   render json: {data: payload, message: "successfully login"},
#   status: 200
# end