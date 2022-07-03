class LikesController < ApplicationController
  before_action :set_like, only: %i[ destroy ]
  before_action :check_like_delete_permission, only: %i[ destroy ]
  before_action :check_authorization
  before_action :check_like_create_permission, only: %i[ create ]
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from ActionController::RoutingError, :with => :not_found
  rescue_from ArgumentError, :with => :not_found

  def create
    @like = Like.new(post_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to post_path(@like.post.id) }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post_id = @like.post.id
    @like.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post_id) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  def check_authorization
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def check_like_create_permission
    if current_user.id != post_params[:user_id].to_i
      redirect_to profile_path(Post.find(post_params[:post_id]).user.id)
    end
  end

  def check_like_delete_permission
    check_authorization
    set_like

    if @like.user.id != current_user.id
      redirect_to profile_path(id: @like.post.user.id)
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:like).permit(:user_id, :post_id)
  end

  def not_found
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
