require 'rails_helper'

describe SponsorPolicy, type: :policy do
  subject { described_class }

  permissions :create? do
    it "should allow create if user in sponsor_admins" do
      committee = build(:committee, slug: Sponsor.sponsor_admins.first)
      user = build(:user)
      user.committees = [committee]
      sponsor = build(:sponsor)
      expect(subject).to permit(user, sponsor)
    end

    it "should disallow create if user not in sponsor_admins" do
      committee = build(:committee)
      user = build(:user)
      user.committees = [committee]
      sponsor = build(:sponsor)
      expect(subject).not_to permit(user, sponsor)
    end
  end
end
