require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user2 }

  before { user1.admin! }

  let!(:correct_user) {
    {
      user: {
        username: Faker.name,
        email: Faker::Internet.email
      }
    }
  }

  let!(:incorrect_user) {
    {
      user: {
        username: Faker.name,
        email: "incorrectmail"
      }
    }
  }

  describe "GET /users" do
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

  describe "GET /users/1/edit" do
    it "should give users list if authenticated" do
      sign_in user1
      get edit_user_path(id: user2)
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /users/1" do
    it "should return status code 302" do
      sign_in user1
      put user_path(id: user2), params: correct_user
      expect(response).to have_http_status(302)
    end

    it "should return status code 422" do
      sign_in user1
      put user_path(id: user2.id), params: incorrect_user
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /users/1" do
    it "should return status code 302" do
      sign_in user1
      delete user_path(id: user2.id)
      expect(response).to have_http_status(302)
    end
  end
end
