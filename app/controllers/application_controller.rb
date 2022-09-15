class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::Cookies
  
  protected
    def current_user
      if cookies[:user_id].nil?
        return
      end

      user_id = cookies.encrypted[:user_id]

      # デコード失敗したらcookieを消す
      if user_id.nil?
        cookies.encrypted[:user_id] = {
          value: nil,
          secure: true,
          expires: 1.second.from_now,
          http_only: true
        }
        return
      end

      User.find(user_id)
    end
    
    def authenticate
      current_user || render_unauthorized
    end

    def render_unauthorized
      render json: {message: "token invalid"},
      status: 401
    end
end
