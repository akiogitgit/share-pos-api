class ApplicationController < ActionController::API
        # include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # include DeviseHackFakeSession
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_account_update_parameters, if: :devise_controller?

  # # sign_up時に、このカラムの値が入るように
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :username])
  # end
  
  # # v1/auth put (user update)で、このカラムも変更できる
  # def configure_account_update_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :username])
  # end
end
