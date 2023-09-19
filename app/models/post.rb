class Post < ApplicationRecord
  after_create :update_user_post_count

  def update_user_post_count
    author.increment!(:posts_counter)
  end
end
