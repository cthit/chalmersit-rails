describe Print do
  it 'should print commandline options' do
    print = FactoryGirl.build(:print)
    print_str = print.to_s
    expect(print_str).to include(" -P 'HUBBEN' ")
    expect(print_str).to include(' -# 100 ')
    expect(print_str).to include(" -o sides='two-sided-long-edge'")
    expect(print_str).to include(" -o collate='True'")
    expect(print_str).to include(" -o page-ranges='3, 5-7'")
    expect(print_str).to include(" -o ppi='600'")
    expect(print_str).to include(" -o media='A3'")

    print.sides = false
    print.ppi = 'auto'
    print_str = print.to_s
    expect(print_str).to include(" -o sides='one-sided'")
    expect(print_str).to include(" -o ppi='auto'")

  end
end
