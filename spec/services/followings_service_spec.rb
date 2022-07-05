require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe FollowingsService, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user3) { create :user, :user3 }
  let!(:following) { create :follow, follower: user1, following: user3 }

  it "should return last created post" do
    expect(FollowingsService.new(user1).make_followings).to eq([ user3 ])
  end
end


