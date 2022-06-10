FactoryBot.define do
  factory :like do
    association :post, factory: [ :post, :user3_post ]
    association :user, factory: [ :user, :user1 ]
  end
end
