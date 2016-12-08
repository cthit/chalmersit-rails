require 'rails_helper'

describe PagePolicy, type: :policy do
  subject { described_class }

  permissions :update? do
    it "should allow update if user in page_admins" do
      committee = "snit"
      user = build(:committee_user)
      user.groups = [committee]
      page = build(:page)
      expect(subject).to permit(user, page)
    end

    it "should disallow update if user not in page_admins" do
      committee = "nollkit"
      user = build(:committee_user)
      user.groups = [committee]
      page = build(:page)
      expect(subject).not_to permit(user, page)
    end
  end
end
