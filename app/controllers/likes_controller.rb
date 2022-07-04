class LikesController < ApplicationController
  load_and_authorize_resource param_method: :like_params
  before_action :set_like, only: %i[ destroy ]
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)

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

  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
