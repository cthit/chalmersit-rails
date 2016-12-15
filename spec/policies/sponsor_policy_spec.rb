require 'rails_helper'

describe SponsorPolicy, type: :policy do
  subject { described_class }

  permissions :create? do
    it "should allow create if user in sponsor_admins" do
      committee = "armit"
      user = build(:committee_user)
      user.groups = [committee]
      sponsor = build(:sponsor)
      expect(subject).to permit(user, sponsor)
    end

    it "should disallow create if user not in sponsor_admins" do
      committee = "nollkit"
      user = build(:committee_user)
      user.groups = [committee]
      sponsor = build(:sponsor)
      expect(subject).not_to permit(user, sponsor)
    end
  end
end
