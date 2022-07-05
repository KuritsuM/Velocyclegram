require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user1) { create :user, :user1 }
  describe "GET /index" do
    it "should give users list if authenticated" do
      sign_in user1
      get users_path(page: 1)
      expect(response).to have_http_status(200)
    end

    it "should redirect to sign in if user not authenticated" do
      get users_path(page: 1)
      expect(response).to redirect_to(new_user_session_path())
    end
  end
end
