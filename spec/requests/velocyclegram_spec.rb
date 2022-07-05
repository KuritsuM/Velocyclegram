require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Velocyclegrams", type: :request do
  let!(:user1) { create :user, :user1 }

  describe "GET /profile" do
    it "should redirect to sign in page if not authorized" do
      get profile_path(id: user1.id)
      expect(response).to redirect_to(user_session_path())
    end

    it "should return profile of user" do
      sign_in user1
      get profile_path(id: user1.id)
      expect(response).to have_http_status(200)
    end
  end
end
