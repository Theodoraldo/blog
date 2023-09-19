class User < ApplicationRecord
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
