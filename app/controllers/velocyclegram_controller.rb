class VelocyclegramController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.find(params[:id])
  end
end
