class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?
    #can :read, Post, user: user
    can :read, Post
    can [ :create, :update, :destroy ], Post, user: user

    can :destroy, Like, user: user
    can :create, Like do |like|
      like.user_id == user.id
    end

    can [ :create, :destroy ], Follow, follower_id: user.id
    can :read, Follow
    #can :read, Follow

    can [ :update, :create ], Commentary, user: user
    can :destroy, Commentary do |comment|
      comment.user == user || comment.post.user == user
    end

    can :read, User
  end
end
