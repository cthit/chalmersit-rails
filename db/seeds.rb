# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 coms = [
  {title_en: 'Student Division Board', title_sv: 'Styrelse', name: 'styrIT', url: 'https://styrit.chalmers.it', email: 'styrit@chalmers.it' },
  {title_en: 'Student Educational Committee', title_sv: 'Studienämnd', name: 'snIT', url: 'https://snit.chalmers.it', email: 'snit@chalmers.it' },
  {title_en: 'Sexmästeri', title_sv: 'Sexmästeri', name: 'sexIT', url: 'https://sexit.chalmers.it', email: 'sexit@chalmers.it' },
  {title_en: 'PR & Rustmästeri', title_sv: 'PR & Rustmästeri', name: 'P.R.I.T.', url: 'https://prit.chalmers.it', email: 'prit@chalmers.it' },
  {title_en: 'Student Reception Committee', title_sv: 'Mottagningskommitté', name: 'NollKIT', url: 'https://nollk.it', email: 'nollkit@chalmers.it' },
  {title_en: 'Business Relations Committee', title_sv: 'Arbetsmarknad', name: 'ArmIT', url: 'https://armit.se', email: 'armit@chalmers.it' },
  {title_en: 'Digital systems', title_sv: 'Digitala system', name: 'digIT', url: 'https://digit.chalmers.it', email: 'digit@chalmers.it' },
  {title_en: 'Standard Bearers', title_sv: 'Fanbärare', name: 'FanbärerIT', url: 'https://fanbärerit.chalmers.it', email: 'fanbärerit@chalmers.it' },
  {title_en: 'Physical Activities', title_sv: 'Fysiska aktiviteter', name: 'frITid', url: 'https://fritid.chalmers.it', email: 'fritid@chalmers.it' },
  {title_en: 'Digital games', title_sv: 'Digitala spel', name: '8-bIT', url: 'https://8bit.chalmers.it', email: '8bit@chalmers.it' },
  {title_en: 'Analog games', title_sv: 'Analoga spel', name: 'DrawIT', url: 'https://drawit.chalmers.it', email: 'drawit@chalmers.it' },
  {title_en: 'Photo Committee', title_sv: 'Foto', name: 'FlashIT', url: 'https://flashit.chalmers.it', email: 'flashit@chalmers.it' },
  {title_en: 'Chugging Committee', title_sv: 'Häfv och odygd', name: 'HookIT', url: 'https://hookit.chalmers.it', email: 'hookit@chalmers.it' },
  {title_en: 'Auditors', title_sv: 'Sektionens revisorer', name: 'Revisorer', url: 'https://revisorer.chalmers.it', email: 'revisorer@chalmers.it' },
  {title_en: 'Nomination Committee', title_sv: 'Valberedning', name: 'Valberedningen', url: 'https://valberedningen.chalmers.it', email: 'valberedningen@chalmers.it'  },
  {title_en: 'Master Reception Committee', title_sv: 'Mastermottagningskommitté', name: 'MRCIT', url: 'https://mrcit.chalmers.it', email: 'mrcit@chalmers.it'  },
  {title_en: 'Legacy', title_sv: 'Legacy', name: 'Legacy', url: 'https://chalmers.it', email: 'digit@chalmers.it'  }
]

 Committee.delete_all
 coms.each do |c|
  desc = "Lorem ipsum osv"
  c.merge!(slug: c[:name].tr('.-','').parameterize, description_en: desc, description_sv: desc )
  Committee.create!(c)
end

main_menu = Menu.create(name: 'main')

[
  { controller: "pages", action: "index", title: "section", preferred_order: 0 },
  { controller: "posts", action: "index", title: "news", preferred_order: 1 },
  { controller: "redirect", action: "courses", title: "courses", preferred_order: 2 },
  { controller: "redirect", action: "findit", title: "services", preferred_order: 3 },
  { controller: "contact", action: "index", title: "contact", preferred_order: 4 },
  { controller: "business", action: "index", title: "business", preferred_order: 5}
].each do |link|
  MenuLink.create(link.merge(menu: main_menu))
end

unless Page.where(slug: "student-division").exists?
  page = Page.create(title_sv: "Sektionen", body_sv: "Lorem ipsum osv", title_en: "Student Division", body_en: "Lorem ipsum etc", slug: "student-division", parent_id: nil)
  frontpage = Frontpage.create(page_id: page.id)
end
unless Page.where(slug: "business").exists?
  page = Page.create(title_sv: "Företag", body_sv: "Lorem ipsum osv", title_en: "Business", body_en: "Lorem ipsum etc", slug: "business", parent_id: nil)
end
