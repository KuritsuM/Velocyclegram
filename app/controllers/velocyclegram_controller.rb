class VelocyclegramController < ApplicationController
  before_action :check_authorization

  def profile
    begin
      @user = User.find(params[:id])
    rescue
      not_found
    end
  end

  private
  def check_authorization
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
