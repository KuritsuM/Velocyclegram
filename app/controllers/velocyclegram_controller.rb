class VelocyclegramController < ApplicationController
  before_action :check_authorization

  def profile
    @user = User.find(params[:id])
  end

  private
  def check_authorization
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
