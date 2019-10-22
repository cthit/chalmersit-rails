FactoryBot.define do
  factory :committee do
    name { "#{Faker::Books::Lovecraft.word}IT" }
    slug { name.downcase }
    url { "chalmers.it" }
    email { "#{slug}@chalmers.it" }
    title_sv { "Smurfkommittén" }
    title_en { "Smurf committee" }
    description_sv { "Testkommittén" }
    description_en { "The committee for testing" }
  end
end
