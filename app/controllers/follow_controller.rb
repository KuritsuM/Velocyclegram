class FollowController < ApplicationController
  before_action :set_follow, only: %i[ destroy ]
  before_action :check_if_user_can_follow, only: %i[ create ]
  before_action :check_if_user_can_unfollow, only: %i[ destroy ]
  before_action :check_authorization, only: %i[ followers, followings ]

  def followers
    @followers = FollowersService.new(params[:id]).make_followers
  end

  def followings
    @followings = FollowingsService.new(params[:id]).make_followings
  end

  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        format.html { redirect_to profile_path(@follow.following.id) }
        format.json { render json: [status: "ok"], status: :created, location: @follow }
      end
    end
  end

  def destroy
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

  def check_authorization
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def check_if_user_can_unfollow
    check_authorization
    set_follow

    if @follow.follower.id != current_user.id
      redirect_to profile_path(@follow.following.id)
    end
  end

  def check_if_user_can_follow
    check_authorization

    if current_user.id != follow_params[:follower_id].to_i
      redirect_to profile_path(follow_params[:following_id])
    end
  end

  def follow_params
    params.require(:follow).permit(:follower_id, :following_id)
  end
end
