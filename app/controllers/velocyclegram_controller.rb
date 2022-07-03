class VelocyclegramController < ApplicationController
  before_action :check_authorization
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from ActionController::RoutingError, :with => :not_found

  def profile
    begin
      @user = User.find(params[:id])
    rescue
      not_found
    end
  end



  private
  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def check_authorization
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
