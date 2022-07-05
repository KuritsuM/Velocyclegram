require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

RSpec.describe Like, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
end
