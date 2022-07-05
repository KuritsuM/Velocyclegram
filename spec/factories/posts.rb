FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new('./spec/factories/images/correct-image.jpeg', 'image/jpeg') }
    trait :user3_post do
      title { "some title" }
      association :user, factory: [ :user, :user3 ]
    end
  end
end
