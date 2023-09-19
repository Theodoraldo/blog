class Post < ApplicationRecord
  after_create :update_user_post_count

  def update_user_post_count
    author.increment!(:posts_counter)
  end

  def recent_comments_post(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
