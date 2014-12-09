FactoryGirl.define do
  factory :print do |f|
  	f.copies 100
  	f.duplex true
  	f.ranges '3, 5-7'
  	f.media 'A3'
  	f.ppi '600'
    f.file 'NO.txt'
    f.username 'user'
    f.password 'pass'
    f.printer 'HUBBEN'
  end
end
