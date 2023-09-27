class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.author = current_user

    if @like.save
      redirect_to user_post_path(current_user, @post), notice: 'You just liked this post'
    else
      redirect_to user_post_path(current_user, @post), alert: 'Something went wrong. Like was not saved.'
    end
  end
end
