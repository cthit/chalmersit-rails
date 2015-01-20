describe Course do
  it { should validate_presence_of :name }
  it { should validate_presence_of :code }

end