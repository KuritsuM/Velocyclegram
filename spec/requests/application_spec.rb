require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Applications", type: :request do
  let!(:user1) { create :user, :user1 }

  describe "GET /index" do
    it "should return code 200 if user doesn't signed in" do
      get "/"
      expect(response).to have_http_status(200)
    end

    it "should redirect to user profile if user signed in" do
      sign_in user1
      get "/"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users" do
    it "should return 200 on sign in page" do
      get "/users/sign_in"
      expect(response).to have_http_status(200)
    end

    it "should return 200 on sign up page" do
      get "/users/sign_up"
      expect(response).to have_http_status(200)
    end
  end
end
