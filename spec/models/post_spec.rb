describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :slug }

  it do
    FactoryGirl.create(:post)
    should validate_uniqueness_of :slug
  end

  # it { should validate_length_of(:title).is_at_least(5).is_at_most(50) }
  # it { should validate_length_of(:body).is_at_least(10).is_at_most(500) }
end
