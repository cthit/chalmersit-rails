require 'rails_helper'

describe PostPolicy, type: :policy do
  subject { described_class }

  permissions :update?, :edit? do
    it "should allow update if user in committee" do
      committee = 'nollkit'
      user = build(:committee_user)
      user.groups = [committee]
      expect(subject).to permit(user, Post.new(group_id: committee))
    end

    it "should disallow update if user not in same committee" do
      committee = 'nollkit'
      other_committee = 'prit'
      user = build(:committee_user)
      user.groups = [committee]
      expect(subject).not_to permit(user, Post.new(group_id: other_committee))
    end
  end
end
