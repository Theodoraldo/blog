class Api::V1::CommentsController < ApplicationController
  def index
    post = Post.find(params['post_id'])
    comments = post.comments
    render json: comments
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Post not found' }, status: :not_found
  end
    
  def create
    if current_user.nil?
      render json: { error: 'User not found' }, status: :not_found
      return
    end
    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(
      text: params['text'],
      author: current_user
    )

    if @comment.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end
end
