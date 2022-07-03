class UsersController < ApplicationController
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
