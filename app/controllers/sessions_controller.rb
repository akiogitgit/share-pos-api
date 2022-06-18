class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # payload = { message: 'ログインしました。', name: user.name }
      render plain: login_user.token
    else
      payload = { errors: ['メールアドレスまたはパスワードが正しくありません。'] }
    end
    # render json: payload
  end

  def logout
  end
end
