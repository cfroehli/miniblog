class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @posts = Post.all
  end

  def show
    @post = Post.with_username.find(params[:id])
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

  def edit
    @post = find_current_user_post
  end

  def update
    @post = find_current_user_post
    flash[:success] = 'Post was successfully updated.' if @post.update(post_params)
    respond_with @post
  end

  def destroy
    @post = find_current_user_post
    flash[:success] = 'Post was successfully destroyed.' if @post.destroy
    respond_with @post
  end

  def followed
    @posts = current_user.followed_posts
    render :index
  end

  def liked
    @posts = current_user.liked_posts
    render :index
  end


  private
    def find_current_user_post
      current_user.posts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "User #{current_user.username} does not own the post [#{params[:id]}]."
      redirect_to :index
    end

    def post_params
      params.require(:post).permit(:content, :featured_image, :featured_image_cache)
    end
end
