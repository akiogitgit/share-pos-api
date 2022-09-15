class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::Cookies
  
  protected
    def current_user
      # authenticate_with_http_token do |token, options|
      #   auth_user = User.find_by(token: token)
      # end
      if cookies[:user_id].nil?
        return
      end
      # user_id = crypt.decrypt_and_verify(cookies[:user_id])
      begin
        user_id = crypt.decrypt_and_verify(cookies[:user_id])
      rescue
        # cookies.delete(:user_id)
        cookies[:user_id] = {
          value: nil,
          secure: true,
          expires: 1.second.from_now,
          http_only: true
        }
        return
      end

      user = User.find(user_id)
    end
    
    def authenticate
      current_user || render_unauthorized
    end

    def render_unauthorized
      cookies.delete(:user_id) if cookies[:user_id].present?
      render json: {message: "token invalid"},
      status: 401
    end

    def crypt
      key_len = ActiveSupport::MessageEncryptor.key_len
      secret = Rails.application.key_generator.generate_key('salt', key_len)
      ActiveSupport::MessageEncryptor.new(secret)
    end
end
