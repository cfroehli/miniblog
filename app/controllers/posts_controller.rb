class PostsController < ApplicationController
  before_action :find_current_user_post, only: [:edit, :update, :destroy]
  respond_to :html, :json

  def index
    @posts = with_username(Post)
  end

  def show
    @post = with_username(Post).find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.new
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

  def followed
    @posts = with_username(current_user.followed_posts)
    render :index
  end

  def liked
    @posts = with_username(current_user.liked_posts)
    render :index
  end


  private
    def find_current_user_post
      @post = with_username(current_user.posts).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "User #{current_user.username} does not own the post [#{params[:id]}]."
      redirect_to :index
    end

    def post_params
      params.require(:post).permit(:content, :featured_image, :featured_image_cache)
    end

    def with_username(posts)
      posts.joins(:user).select('posts.*, users.username as user_name')
    end
end
