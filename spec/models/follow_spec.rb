require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Follow, type: :model do
  it { is_expected.to belong_to(:following) }
  it { is_expected.to belong_to(:follower) }
end
