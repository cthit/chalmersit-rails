require 'csv'
require 'net/http'

def get_all_csv
  uri = URI 'http://print.chalmers.se/public/pls.cgi'
  res = Net::HTTP.post_form(uri, 'textver' => 'CSV export')
  xml = Nokogiri::XML(res.body)
  text = xml.css('pre').children.text.strip
  CSV.parse(text, {
    col_sep: "\t",
    header_converters: :symbol,
    headers: true,
    return_headers: true
  }).drop(1)
end

namespace :cthit do
  desc "Update glorious printers"
  task update_printers: :environment do
    csv = get_all_csv
    Printer.where('name NOT IN (?)', csv.map{ |c| c[:printer].strip }).delete_all

    csv.each do |printer|
      pp = Printer.find_or_initialize_by(name: printer[:printer].strip)
      pp.update_attributes({
        location: printer[:printer].strip,
        media: printer[:size].strip
      })
      puts pp
    end
  end
end
