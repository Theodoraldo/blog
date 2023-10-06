class Api::V1::CommentsController < ApplicationController
    def index
        post = Post.find(params['post_id'])
        comments = post.comments
        render json: comments
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Post not found' }, status: :not_found
      end
end
