# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 coms = [{:title=>"Styrelse", :name=>"styrIT"}, {:title=>"Studienämnd", :name=>"snIT"}, {:title=>"Sexmästeri", :name=>"sexIT"}, {:title=>"PR & Rustmästeri", :name=>"P.R.I.T."}, {:title=>"Mottagningskommitté", :name=>"NollKIT"}, {:title=>"Arbetsmarknad", :name=>"ArmIT"}, {:title=>"Digitala system", :name=>"digIT"}, {:title=>"Fanbärare", :name=>"FanbärerIT"}, {:title=>"Fysiska aktiviteter", :name=>"frITid"}, {:title=>"Digitala spel", :name=>"8-bIT"}, {:title=>"Analoga spel", :name=>"DrawIT"}, {:title=>"Foto", :name=>"FlashIT"}, {:title=>"Häfv och odygd", :name=>"HookIT"}, {:title=>"Sektionens revisorer", :name=>"Revisorer"}, {:title=>"Valberedning", :name=>"Valberedningen"}]

 coms.each do |c|
  c.merge!(slug: c[:name].gsub('.', '').parameterize)
  Committee.create!(c)
end