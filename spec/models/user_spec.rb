require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to have_one_attached(:avatar) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to have_many(:post) }
  it { is_expected.to have_many(:followings) }
  it { is_expected.to have_many(:followers) }
  it { is_expected.to have_many(:commentary) }
  it { is_expected.to have_many(:like) }

  context 'devise validator' do
    let!(:user) { create :user, :correct_user }
    let(:incorrect_user) { FactoryBot.build :user, :duplicated_email }

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
