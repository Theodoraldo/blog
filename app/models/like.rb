class Like < ApplicationRecord
  after_create :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
