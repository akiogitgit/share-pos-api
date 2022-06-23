class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # before_action :authenticate_admin!
  
  private
  # これで適切なカラムを受け付けるよう修正
  def sign_up_params
    params.permit(:username, :nickname, :email, :password, :password_confirmation)
  end
end