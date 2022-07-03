class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from ActionController::RoutingError, :with => :not_found
  rescue_from ArgumentError, :with => :not_found

  def show
    @users = User.order('id DESC').page(params[:page])
  end

  private
  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
