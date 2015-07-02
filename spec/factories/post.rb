FactoryGirl.define do
  factory :post do
    title_en 'Post title - EN'
    title_sv 'Post title - SV'
    body_en "# Header\n\n- list\n- list2\n- list3 - EN"
    body_sv "# Header\n\n- list\n- list2\n- list3 - SV"
    sticky false
    association :user
    group_id 'digit'
  end
end
