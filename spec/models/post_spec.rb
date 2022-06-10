require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Post, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
