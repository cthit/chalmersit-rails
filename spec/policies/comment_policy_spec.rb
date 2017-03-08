require 'rails_helper'

describe CommentPolicy, type: :policy do
  subject { described_class }

  permissions :create? do
    it "should allow create if user is present" do
      user = build(:user)
      comment = Comment.new
      expect(subject).to permit(user, comment)
    end

    it "should disallow create if no user is present" do
      comment = Comment.new
      expect(subject).not_to permit(nil, comment)
    end
  end

  permissions :destroy? do
    it "should allow destroy if user is creator" do
      user = build(:user)
      comment = Comment.new(user: user)
      expect(subject).to permit(user, comment)
    end

    it "should allow destroy if user is admin" do
      user = build(:admin_user)
      comment = Comment.new
      expect(subject).to permit(user, comment)
    end

    it "should disallow destroy if user is other" do
      user = build(:user)
      comment = Comment.new
      expect(subject).not_to permit(user, comment)
    end
  end


end
