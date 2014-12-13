describe Page do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :slug }

  it do
    FactoryGirl.create(:page)
    should validate_uniqueness_of :title
  end

end
