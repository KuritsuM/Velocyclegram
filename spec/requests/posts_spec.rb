require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Posts", type: :request do
  let!(:user1) { create :user, :user1 }
  let!(:user3) { create :user, :user3 }
  let!(:user_post) { create :post, title: "title", user: user3 }

  describe "GET /posts" do
    it "should return 200 if user signed in" do
      sign_in user1
      get new_post_path
      expect(response).to have_http_status(200)
    end

    it "should redirect to root if user not signed in" do
      get new_post_path
      expect(response).to redirect_to(new_user_session_path())
    end

    it "should return 200 if user logged in and trying edit post" do
      sign_in user3
      get edit_post_path(id: user_post.id)
      expect(response).to have_http_status(200)
    end
  end

  let!(:correct_post) {
    {
      post:
        {
          title: "lorem",
          user_id: user1.id,
          image: Rack::Test::UploadedFile.new('./spec/factories/images/correct-image.jpeg', 'image/jpeg'),
        }
    }
  }
  describe "POST /posts" do
    it "should redirect to user profile" do
      sign_in user1
      post '/posts', params: correct_post
      expect(response).to redirect_to(profile_path(id: user1.id))
    end

    it "should have 422 http status" do
      sign_in user1
      post '/posts', params: { post: { user_id: user1.id } }
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT /posts" do
    it "should redirect to user profile if post update sucessfully" do
      sign_in user1
      post '/posts', params: correct_post
      patch "/posts/#{user1.post[0].id}", params: { post: { title: "new lorem", user_id: user1.id } }
      expect(response).to redirect_to(profile_path(id: user1.id))
    end

    it "should redirect to user trying update post of another profile" do
      sign_in user1
      expect { patch "/posts/#{user_post.id}", params: correct_post }.to raise_exception(CanCan::AccessDenied)
    end

    it "should have 422 http status code" do
      sign_in user3
      patch "/posts/#{user_post.id}", params: { post: { title: "", user_id: user3.id } }
      expect(response).to have_http_status(422)
    end
  end

  describe "DESTORY /posts" do
    it "should redirect to user profile if post update sucessfully" do
      sign_in user3
      delete "/posts/#{user_post.id}"
      expect(response).to redirect_to(profile_path(id: user3.id))
    end

    it "should redirect to user trying update post of another profile" do
      sign_in user1
      expect { delete "/posts/#{user_post.id}" }.to raise_exception(CanCan::AccessDenied)
    end
  end
end
