# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    flash.keep
    @user = User.find(params[:id])
  end
end
