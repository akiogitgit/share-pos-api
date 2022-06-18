class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
    # user = User.find_by(username: params[:username])
    # if user&.authenticate(params[:password])
      # session[:user_id] = user.id
      payload = { message: 'ログインしました。', name: user.name }
      # render plain: user.token
    else
      if user.present?
        payload = { errors: ['パスワードが正しくありません。'] }
      else
        payload = { errors: ['メールアドレスが存在しません。'] }
      end
    end
    render json: payload
    # render json: {errors: params[:session][:username]}
  end

  def logout
  end
end
