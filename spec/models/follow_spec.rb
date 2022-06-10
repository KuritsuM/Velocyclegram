require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Follow, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user2 }
  let!(:user3) { create :user, :user3 }

  let!(:follow1) { Follow.create(follower_id: user1.id, following_id: user2.id) }
  let!(:follow2) { Follow.create(follower_id: user1.id, following_id: user3.id) }
  let!(:follow3) { Follow.create(follower_id: user2.id, following_id: user1.id) }

  it "should give all user1 followers" do
    expect(Follow.make_followers(user1.id)).to eq([user2])
  end

  it "should give all user1 followings" do
    expect(Follow.make_followings(user1.id)).to eq([user2, user3])
  end
end
