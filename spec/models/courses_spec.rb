describe Course do
  it { should validate_presence_of :name }
  it { should validate_presence_of :code }

  it do
    FactoryGirl.create(:course)
    should validate_uniqueness_of :code
  end

end