require 'rails_helper'

describe PostPolicy, type: :policy do
  subject { described_class }

  permissions :update? do
    it "should allow update if user in committee" do
      committee = build(:committee)
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = committee

      expect(subject).to permit(user, post)
    end

    it "should disallow update if user not in same committee" do
      committee = build(:committee)
      other_committee = build(:committee)
      other_committee.slug = "another"
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = other_committee

      expect(subject).not_to permit(user, post)
    end
  end

  permissions :edit? do
    it "should allow edit if user in committee" do
      committee = build(:committee)
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = committee

      expect(subject).to permit(user, post)
    end

    it "should disallow edit if user not in same committee" do
      committee = build(:committee)
      other_committee = build(:committee)
      other_committee.slug = "another"
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = other_committee
      expect(subject).not_to permit(user, post)
    end
  end

  permissions :destroy? do
    it "should allow destroy if user in committee" do
      committee = build(:committee)
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = committee

      expect(subject).to permit(user, post)
    end

    it "should disallow destroy if user not in same committee" do
      committee = build(:committee)
      other_committee = build(:committee)
      other_committee.slug = "another"
      user = build(:committee_user)
      post = build(:post)

      user.committees = [committee]
      post.group = other_committee

      expect(subject).not_to permit(user, post)
    end
  end

end
