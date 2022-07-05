require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Post, type: :model do
  it { is_expected.to have_one_attached(:image) }
  it { is_expected.to have_many(:like) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:title) }
end
