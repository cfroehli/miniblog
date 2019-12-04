class PostsController < ApplicationController
  before_action :find_current_user_post, only: [:edit, :update, :destroy]
  before_action :find_post, only: [:show]
  respond_to :html, :json

  def index
    @posts = Post.order(updated_at: :desc)
    respond_with @posts
  end

  def show
    respond_with @post
  end

  def new
    @post = current_user.posts.new
    respond_with @post
  end

  def create
    @post = current_user.posts.new(post_params)
    flash[:success] = 'Post was successfully created.' if @post.save
    respond_with @post
  end

  def update
    flash[:success] = 'Post was successfully updated.' if @post.update(post_params)
    respond_with @post
  end

  def destroy
    flash[:success] = 'Post was successfully destroyed.' if @post.destroy
    respond_with @post
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def find_current_user_post
      @post = current_user.posts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "User #{current_user.username} does not own the post [#{params[:id]}]."
      redirect_to :action => 'index'
    end

    def post_params
      params.require(:post).permit(:content)
    end
end
