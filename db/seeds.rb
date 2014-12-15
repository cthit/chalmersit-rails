# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 coms = [
  { title: 'Styrelse', name: 'styrIT', url: 'http://styrit.chalmers.it', email: 'styrit@chalmers.it' },
  { title: 'Studienämnd', name: 'snIT', url: 'http://snit.chalmers.it', email: 'snit@chalmers.it' },
  { title: 'Sexmästeri', name: 'sexIT', url: 'http://sexit.chalmers.it', email: 'sexit@chalmers.it' },
  { title: 'PR & Rustmästeri', name: 'P.R.I.T.', url: 'http://prit.chalmers.it', email: 'prit@chalmers.it' },
  { title: 'Mottagningskommitté', name: 'NollKIT', url: 'http://nollk.it', email: 'nollkit@chalmers.it' },
  { title: 'Arbetsmarknad', name: 'ArmIT', url: 'http://armit.se', email: 'armit@chalmers.it' },
  { title: 'Digitala system', name: 'digIT', url: 'http://digit.chalmers.it', email: 'digit@chalmers.it' },
  { title: 'Fanbärare', name: 'FanbärerIT', url: 'http://fanbärerit.chalmers.it', email: 'fanbärerit@chalmers.it' },
  { title: 'Fysiska aktiviteter', name: 'frITid', url: 'http://fritid.chalmers.it', email: 'fritid@chalmers.it' },
  { title: 'Digitala spel', name: '8-bIT', url: 'http://8bit.chalmers.it', email: '8bit@chalmers.it' },
  { title: 'Analoga spel', name: 'DrawIT', url: 'http://drawit.chalmers.it', email: 'drawit@chalmers.it' },
  { title: 'Foto', name: 'FlashIT', url: 'http://flashit.chalmers.it', email: 'flashit@chalmers.it' },
  { title: 'Häfv och odygd', name: 'HookIT', url: 'http://hookit.chalmers.it', email: 'hookit@chalmers.it' },
  { title: 'Sektionens revisorer', name: 'Revisorer', url: 'http://revisorer.chalmers.it', email: 'revisorer@chalmers.it' },
  { title: 'Valberedning', name: 'Valberedningen', url: 'http://valberedningen.chalmers.it', email: 'valberedningen@chalmers.it'  }
]

 coms.each do |c|
  c.merge!(slug: c[:name].gsub('.', '').parameterize, description: 'lorem ipsum och så vidare')
  Committee.create!(c)
end
