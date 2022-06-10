require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe User, type: :model do
  context 'login validator' do
    let!(:user) { create :user, :correct_user }
    let(:incorrect_user) { FactoryBot.build :user, :duplicated_email }

    it "should be equal to username" do
      expect(user.login).to eq('kurisum')
    end

    it "should add error" do
      expect(incorrect_user.valid?).to be(false)
    end

    let(:username) { { login: user.username } }
    let(:email) { { login: user.email } }

    it "finds user by username" do
      authenticated = User.find_for_database_authentication(username)
      expect(authenticated).to eq(user)
    end

    it "finds user by email" do
      authenticated = User.find_for_database_authentication(email)
      expect(authenticated).to eq(user)
    end

    let(:another_warden_condition) { { username: user.username } }

    it "finds user by username with another warden condition" do
      authenticated = User.find_for_database_authentication(another_warden_condition)
      expect(authenticated).to eq(user)
    end
  end
end
