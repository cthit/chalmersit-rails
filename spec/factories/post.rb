FactoryGirl.define do
  factory :post do |f|
    f.title 'Post title'
    f.body "# Header\n\n- list\n- list2\n- list3"
    f.sticky false
    f.user_id 'smurf'
  end
end
