class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      payload = { message: 'ログインしました。', token: user.token }
      # render plain: user.token
    else
      if user.present?
        payload = { errors: ['パスワードが正しくありません。'] }
      else
        payload = { errors: ['メールアドレスが存在しません。'] }
      end
    end
    render json: payload
  end

  def logout
  end
end
