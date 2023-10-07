class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250, too_long: '250 charactors are allowed' }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :update_user_post_count
  after_destroy :update_user_post_count

  def update_user_post_count
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments_post(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def limit_sentence(content)
    words = content.split
    return content unless words.count > 30

    limited_words = words.take(30)
    "#{limited_words.join(' ')} . . ."
  end
end
