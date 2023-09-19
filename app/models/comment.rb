class Comment < ApplicationRecord
  after_create :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
