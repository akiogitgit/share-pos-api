class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
end
