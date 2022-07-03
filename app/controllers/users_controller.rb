class UsersController < ApplicationController
  def show
    @users = User.order('id DESC').page(params[:page])
  end
end
