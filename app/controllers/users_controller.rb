class UsersController < ApplicationController
  respond_to :html, :json

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
