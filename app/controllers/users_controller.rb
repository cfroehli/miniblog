class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  respond_to :html, :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
    respond_with @user
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
