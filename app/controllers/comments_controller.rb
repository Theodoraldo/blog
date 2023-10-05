class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully created.'
    else
      redirect_to user_post_path(current_user, @post), alert: 'Comment could not be saved.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to(&:turbo_stream)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
