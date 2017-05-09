describe Page do
  it { should validate_presence_of :title_en }
  it { should validate_presence_of :title_sv }
  it { should validate_presence_of :body_en }
  it { should validate_presence_of :body_sv }
  it { should validate_presence_of :slug }
end
