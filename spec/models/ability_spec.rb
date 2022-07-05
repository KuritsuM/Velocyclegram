require 'rails_helper'

RSpec.describe Ability, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user2 }
  let!(:user3) { create :user, :user3 }
  let!(:user4) { create :user, :user4 }

  let!(:user_ability) {
    user1.user!
    Ability.new(user1)
  }

  let!(:moderator_ability) {
    user2.moderator!
    Ability.new(user2)
  }

  let!(:older_admin_ability) {
    user3.admin!
    Ability.new(user3)
  }

  let!(:younger_admin_ability) {
    user4.admin!
    Ability.new(user4)
  }

  context "admin ability test" do
    it { expect(older_admin_ability.can? :merge, Post).to be(true) }
    it { expect(older_admin_ability.can? :merge, Commentary).to be(true) }
    it { expect(older_admin_ability.can? :merge, Like).to be(true) }
    it { expect(older_admin_ability.can? :merge, Follow).to be(true) }
    it { expect(older_admin_ability.cannot? :merge, User).to be(true) }
    it { expect(older_admin_ability.can? :destroy, user4).to be(true) }
    it { expect(older_admin_ability.can? :update, user4).to be(true) }
    it { expect(older_admin_ability.can? :destroy, user2).to be(true) }
    it { expect(older_admin_ability.can? :update, user2).to be(true) }
  end

  context "younger admin ability test" do
    it { expect(younger_admin_ability.cannot? :destroy, user3).to be(true) }
    it { expect(younger_admin_ability.cannot? :update, user3).to be(true) }
    it { expect(younger_admin_ability.cannot? :destroy, user4).to be(true) }
    it { expect(younger_admin_ability.can? :destroy, user2 ).to be(true)}
    it { expect(younger_admin_ability.can? :update, user2).to be(true) }
  end

  context "moderator ability test" do
    it { expect(moderator_ability.can? :merge, Post).to be(true) }
    it { expect(moderator_ability.can? :merge, Commentary).to be(true) }
  end

  context "user ability test" do
    it { expect(user_ability.can? :create, Post).to be(true) }
    it { expect(user_ability.can? :read, Post).to be(true) }
    it { expect(user_ability.can? :update, Post).to be(true) }
    it { expect(user_ability.can? :destroy, Post).to be(true) }

    it { expect(user_ability.can? :destroy, Like).to be(true) }
    it { expect(user_ability.can? :create, Like).to be(true) }

    it { expect(user_ability.can? :create, Follow).to be(true) }
    it { expect(user_ability.can? :read, Follow).to be(true) }
    it { expect(user_ability.can? :destroy, Follow).to be(true) }

    it { expect(user_ability.can? :create, Commentary).to be(true) }
    it { expect(user_ability.can? :update, Commentary).to be(true) }
    it { expect(user_ability.can? :destroy, Commentary).to be(true) }
  end
end
