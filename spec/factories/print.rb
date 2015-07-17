FactoryGirl.define do
  factory :print do |f|
  	f.copies 100
  	f.duplex true
    f.collate true
  	f.ranges '3, 5-7'
  	f.ppi '600'
    f.media 'A3'
    f.file Tempfile.new 'test.txt'
    f.username 'user'
    f.password 'pass'
    f.printer
  end
end


FactoryGirl.define do
  factory :printer do |f|
    f.name 'HUBBEN'
    f.media 'A4 A3 A2'
  end
end
