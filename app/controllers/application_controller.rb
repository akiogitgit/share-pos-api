class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  
  protected
    def current_user
      authenticate_with_http_token do |token, options|
        auth_user = User.find_by(token: token)
      end
    end
    
    def authenticate
      current_user || render_unauthorized
    end

    def render_unauthorized
      render json: {message: "token invalid"},
      status: 401
    end
end
