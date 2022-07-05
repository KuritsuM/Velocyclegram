require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe UsersPaginationService, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user4 }
  let!(:user3) { create :user, :user3 }

  let!(:users_array) { [ user1, user2, user3 ].reverse! }
  it "should return list of users" do
    expect(UsersPaginationService.new(1).make_users_on_page.to_a).to eq(users_array)
  end

  it "should return empty array if page doesn't exists" do
    expect(UsersPaginationService.new(1000).make_users_on_page.to_a).to eq([])
  end
end
