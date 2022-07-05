class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def show
    @users = UsersPaginationService.new(params[:page]).make_users_on_page

    authorize! :read, @users[0]
  end
end
