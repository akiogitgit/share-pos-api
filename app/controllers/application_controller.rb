class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::Cookies
  
  protected
    def current_user
      if cookies[:token].nil?
        return
      end

      token = cookies.encrypted[:token]

      # デコード失敗したらcookieを消す
      if token.nil?
        # cookies.encrypted[:token] = {
        #   value: nil,
        #   secure: true,
        #   expires: 0.second.from_now,
        #   http_only: true
        # }
        cookies[:token] = {
          value: nil,
          secure: true,
          expires: 0.second.from_now,
          http_only: true
        }
        return
      end

      User.find_by(token: token)
    end
    
    def authenticate
      current_user || render_unauthorized
    end

    def render_unauthorized
      render json: {message: "token invalid"},
      status: 401
    end
end
