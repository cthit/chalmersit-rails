describe Print do
  it 'should print commandline options' do
    print = FactoryGirl.build(:print)
    print_str = print.to_s
    expect(print_str).to include(" -P 'HUBBEN' ")
    expect(print_str).to include(' -# 100 ')
    expect(print_str).to include(" -o duplex='two-sided-long-edge'")
    expect(print_str).to include(" -o collate='True'")
    expect(print_str).to include(" -o ranges='3, 5-7'")
    expect(print_str).to include(" -o ppi='600'")
    expect(print_str).to include(" -o media='A3'")

    print.duplex = false
    print.ppi = 'auto'
    print_str = print.to_s
    expect(print_str).to include(" -o duplex='one-sided'")
    expect(print_str).to include(" -o ppi='auto'")

  end
end
