require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Velocyclegrams", type: :request do
  let!(:user1) { create :user, :user1 }

  describe "GET /profile" do
    it "should redirect to root if not authorized" do
      get profile_path(id: user1.id)
      expect(response).to redirect_to('/')
    end

    it "should return profile of user" do
      sign_in user1
      get profile_path(id: user1.id)
      expect(response).to have_http_status(200)
    end

    it "should return 404 page if profile doesn't exists" do
      sign_in user1
      get profile_path(id: user1.id + Random.new.rand(user1.id..user1.id+100))
      expect(response).to have_http_status(404)
    end


  end
end
