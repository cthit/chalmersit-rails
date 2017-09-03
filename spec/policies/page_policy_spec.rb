require 'rails_helper'

describe PagePolicy, type: :policy do
  subject { described_class }

  permissions :update? do
    it "should allow update if user in page_admins" do
      committee = build(:committee, slug: Page.page_admins.first)
      user = build(:user)
      user.committees = [committee]
      page = build(:page)
      expect(subject).to permit(user, page)
    end

    it "should disallow update if user not in page_admins" do
      committee = build(:committee)
      user = build(:user)
      user.committees = [committee]
      page = build(:page)
      expect(subject).not_to permit(user, page)
    end
  end
end
