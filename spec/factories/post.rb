FactoryGirl.define do
  factory :post do |f|
    f.title_en 'Post title - EN'
    f.title_sv 'Post title - SV'
    f.body_en "# Header\n\n- list\n- list2\n- list3 - EN"
    f.body_sv "# Header\n\n- list\n- list2\n- list3 - SV"
    f.sticky false
    f.user_id 'Smurf'
    f.group_id 'digIT'
  end
end
