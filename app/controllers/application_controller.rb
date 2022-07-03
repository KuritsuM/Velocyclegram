class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @posts = LastCreatedPostsService.new.get_posts
  end

  protected

  # set the fields with user account actions
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :avatar])
  end
end
