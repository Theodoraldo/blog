class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, Post
    can :index, Post

    return unless user.present?

    can :new, Post, author: user
    can :create, Post, author: user
    can :destroy, Post, author: user

    can :create, Comment, author: user
    can :destroy, Comment, author: user

    return unless user.role == 'admin'

    can :destroy, Post
    can :destroy, Comment
  end
end
