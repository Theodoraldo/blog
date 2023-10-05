class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.recent_comments_post(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    if @post.destroy
      redirect_to user_path(@user), notice: 'Post was deleted.'
    else
      redirect_to user_path(@user), alert: 'Error deleting the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
