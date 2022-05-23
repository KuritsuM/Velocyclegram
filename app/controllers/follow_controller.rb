class FollowController < ApplicationController
  def followers
    begin
      @followers = Follow.make_followers(params[:id])
    rescue
      @followers = nil # todo redirect to 403 page
    end
  end

  def followings
    begin
      @followings = Follow.make_followings(params[:id])
    rescue
      @followings = nil # todo redirect to 403 page
    end
  end

  def create
    begin
      Follow.create(follower_id: User.find(current_user[:id]).id, following_id: User.find(params[:format]).id)
      redirect_to action: 'profile', controller: "velocyclegram", id: params[:format]
    end
  end

  def delete
    begin
      Follow.where(["follower_id = :follower_id and following_id = :following_id",
                   { follower_id: current_user[:id], following_id: params[:format]}]).destroy_all

      redirect_to action: 'profile', controller: "velocyclegram", id: params[:format]
    end
  end
end
