class FollowController < ApplicationController
  before_action :set_follow, only: %i[ destroy ]
  before_action :authenticate_user!

  def followers
    @followers = FollowersService.new(params[:id]).make_followers
  end

  def followings
    @followings = FollowingsService.new(params[:id]).make_followings
  end

  def create
    @follow = Follow.new(follow_params)
    authorize! :create, @follow

    respond_to do |format|
      if @follow.save
        format.html { redirect_to profile_path(@follow.following.id) }
        format.json { render json: [status: "ok"], status: :created, location: @follow }
      end
    end
  end

  def destroy
    authorize! :destroy, @follow   # otherwise, it will rise exception because cancancan will try found follow
                                   # with id equal to user id on load_and_authorize_resource call
    profile = @follow.following.id
    @follow.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(profile) }
      format.json { head :no_content }
    end
  end

  private

  def set_follow
    @follow = Follow.find(params[:id])
  end

  def follow_params
    params.require(:follow).permit(:follower_id, :following_id)
  end
end
