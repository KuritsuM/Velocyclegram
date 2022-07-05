class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.present?
      #can :read, Post, user: user
      can :read, Post
      can [:create, :update, :destroy], Post, user: user

      can :destroy, Like, user: user
      can :create, Like do |like|
        like.user_id == user.id
      end

      can [:create, :destroy], Follow, follower_id: user.id
      can :read, Follow
      #can :read, Follow

      can [:update, :create], Commentary, user: user
      can :destroy, Commentary do |comment|
        comment.user == user || comment.post.user == user
      end

      can :read, User
    end

    if user.moderator?
      can :read , User
      can :manage, [ Post, Commentary ]
    end

    if user.admin?
      can :manage, [ Post, Like, Commentary, Follow ]

      can [ :read, :create ], User
      can :destroy, User do |_user|
        _user.id > user.id || !_user.admin?
      end
      can :update, User do |_user|
        _user.id > user.id || !_user.admin?
      end

    end
  end
end
