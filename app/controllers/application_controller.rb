class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    if user_signed_in?
      redirect_to action: 'profile', controller: "velocyclegram", id: current_user.id
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :avatar])
  end
end
