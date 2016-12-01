require 'rails_helper'

describe PostPolicy, type: :policy do
  subject { described_class }

  permissions :update? do
    it "should allow update if user in committee" do
      committee = 'nollkit'
      user = build(:committee_user)
      user.groups = [committee]
      post = build(:post)
      post.group_id = committee
      expect(subject).to permit(user, post)
    end

    it "should disallow update if user not in same committee" do
      committee = 'nollkit'
      other_committee = 'prit'
      user = build(:committee_user)
      user.groups = [committee]
      post = build(:post)
      post.group_id = other_committee
      expect(subject).not_to permit(user, post)
    end
  end

  permissions :edit? do
    it "should allow edit if user in committee" do
      committee = 'nollkit'
      user = build(:committee_user)
      user.groups = [committee]
      post = build(:post)
      post.group_id = committee
      expect(subject).to permit(user, post)
    end

    it "should disallow edit if user not in same committee" do
      committee = 'nollkit'
      other_committee = 'prit'
      user = build(:committee_user)
      user.groups = [committee]
      post = build(:post)
      post.group_id = other_committee
      expect(subject).not_to permit(user, post)
    end
  end
end
