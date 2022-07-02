class VelocyclegramController < ApplicationController
  def profile
    if !user_signed_in?
      redirect_to '/'
    end

    #begin
      @user = User.find(params[:id])
=begin
    rescue
      not_found
    end
=end
  end

=begin
  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
=end
end
