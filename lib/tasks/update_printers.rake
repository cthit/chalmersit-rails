require 'csv'
require 'net/http'

def get_all_csv
  uri = URI 'https://print.chalmers.se/public/pls.cgi'
  res = Net::HTTP.post_form(uri, 'textver' => 'CSV export')
  xml = Nokogiri::XML(res.body)
  text = xml.css('pre').children.text.strip
  CSV.parse(text, {
    col_sep: "\t",
    header_converters: [lambda {|f| f.strip}, :symbol],
    converters: lambda {|f| f ? f.strip : nil },
    headers: true
  })
end

namespace :cthit do
  desc "Update glorious printers"
  task update_printers: :environment do
    csv = get_all_csv
    Printer.where('name NOT IN (?)', csv.map{ |c| c[:printer] }).delete_all

    csv.each do |printer|
      pp = Printer.find_or_initialize_by(name: printer[:printer])
      pp.update_attributes({
        location: printer[:location],
        media: printer[:size]
      })
      puts pp
    end
  end
end
