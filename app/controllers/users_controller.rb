# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :html, :json

  def index
    @users = User.all
  end

  def show
    @user = find_user
  end

  private

  def find_user
    User.find(params[:id])
  end
end
