require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe LastCreatedPostsService, type: :model do
  let!(:user3) { create :user, :user3 }
  let!(:user_post) { create :post, title: "title", user: user3 }

  it "should return last created post" do
    expect(LastCreatedPostsService.new(1).get_posts.to_a).to eq([ user_post ])
  end
end

