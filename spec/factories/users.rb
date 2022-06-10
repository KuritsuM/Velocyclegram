require 'faker'

FactoryBot.define do
  factory :user do
    trait :correct_user do
      username { 'kurisum' }
      email { 'mycoolemail@gmail.com' }
      password { 'example_password' }
    end

    trait :duplicated_email do
      username { 'mycoolemail@gmail.com' }
      email { Faker::Internet.email }
      password { 'password' }
    end

    trait :user1 do
      username { 'user1' }
      email { Faker::Internet.email }
      password { 'example_password' }
    end

    trait :user2 do
      username { 'user2' }
      email { Faker::Internet.email }
      password { 'example_password' }
    end

    trait :user3 do
      username { 'user3' }
      email { Faker::Internet.email }
      password { 'example_password' }
    end

    trait :user4 do
      username { 'user4' }
      email { Faker::Internet.email }
      password { 'example_password' }
    end
  end
end
