class VelocyclegramController < ApplicationController
  def profile
    begin
      @user = User.find(params[:id])
    rescue
      @user = nil # todo redirect to 403 page
    end
  end
end
