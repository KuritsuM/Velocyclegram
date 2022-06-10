FactoryBot.define do
  factory :post do
    trait :user3_post do
      title { "some title" }
      association :user, factory: [ :user, :user3 ]
    end
  end
end
