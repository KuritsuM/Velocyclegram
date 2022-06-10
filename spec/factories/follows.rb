FactoryBot.define do
  factory :follow do
    follower_id { (association :user, :user1).id }
    following_id { (association :user, :user2).id }
  end
end
