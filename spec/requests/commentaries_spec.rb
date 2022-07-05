require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Commentaries", type: :request do
  let!(:user1) { create :user, :user1 }
  let!(:user3) { create :user, :user3 }
  let!(:user_post) { create :post, title: "title", user: user3 }
  let!(:commentary) { create :commentary, user: user3, post: user_post }

  describe "GET /edit" do
    it "should raise AccessDenied if user isn't signed in" do
      expect { get edit_commentary_path(id: commentary.id) }.to raise_exception(CanCan::AccessDenied)
    end

    it "should return 200 code if user authorized and trying edit his commentary" do
      sign_in user3
      get edit_commentary_path(id: commentary.id)
      expect(response).to have_http_status(200)
    end

    it "should raise AccessDenied if user authorized and trying edit not his commentary" do
      sign_in user1
      expect{ get edit_commentary_path(id: commentary.id) }.to raise_exception(CanCan::AccessDenied)
    end
  end

  describe "DELETE /commentaries" do
    it "should raise AccessDenied if user trying delete not his post" do
      sign_in user1
      expect { delete commentary_path(id: commentary.id) }.to raise_exception(CanCan::AccessDenied)
      #expect(response).to redirect_to(profile_path(id: commentary.post.user.id))
      expect(Commentary.find(commentary.id).id).to eq(commentary.id)
    end

    it "should redirect if user trying delete his post" do
      sign_in user3
      delete commentary_path(id: commentary.id)
      expect(response).to redirect_to(profile_path(id: commentary.post.user.id))
      expect { Commentary.find(commentary.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  let(:correct_comment) { { commentary: { comment_text: "sample comment text", post_id: user_post.id,
                                          user_id: user1.id } } }
  let(:incorrect_comment) { { commentary: { comment_text: "", post_id: user_post.id,
                                            user_id: user1.id } } }
  describe "POST /commentaries" do
    it "should create comment if user signed in" do
      sign_in user1
      post "/commentaries", params: correct_comment
      expect(response).to redirect_to(post_path(id: commentary.post.id))
    end

    it "should return 422 status if comment_text field empty" do
      sign_in user1
      post "/commentaries", params: incorrect_comment
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT /commentaries" do
    it "should raise AccessDenied if user trying update not his commentary" do
      sign_in user1
      expect { put "/commentaries/#{commentary.id}", params: correct_comment }.to raise_exception(CanCan::AccessDenied)
    end

    it "should redirect if user update his commentary" do
      sign_in user3
      put "/commentaries/#{commentary.id}", params: correct_comment
      expect(response).to redirect_to(profile_path(user3.id))
    end

    it "should return 422 if new commentary can't pass validation" do
      sign_in user3
      put "/commentaries/#{commentary.id}", params: incorrect_comment
      expect(response).to have_http_status(422)
    end
  end
end
