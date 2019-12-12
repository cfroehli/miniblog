class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_NAME"], password: ENV["HTTP_BASIC_AUTH_PASS"] if Rails.env.production?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    added_attrs += [ :profile, :blog_url ]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
