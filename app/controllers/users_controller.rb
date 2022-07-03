class UsersController < ApplicationController
  def show
    @users = UsersPaginationService.new(params[:page]).make_users_on_page
  end
end
