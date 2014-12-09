describe Print do
  it 'should print commandline options' do
    print = FactoryGirl.build(:print)
    print_str = print.to_s
    expect(print_str).to include(' -# 100 ')
    expect(print_str).to include(' -o duplex=two-sided-long-edge')
    expect(print_str).to include(' -# 100 ')
    expect(print_str).to include(' -# 100 ')
    expect(print_str).to include(' -# 100 ')

  end
end
