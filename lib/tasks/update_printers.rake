require 'csv'
require 'net/http'

def get_all_csv
  uri = URI 'https://print.chalmers.se/public/pls.cgi'
  res = Net::HTTP.post_form(uri, 'textver' => 'CSV export')
  xml = Nokogiri::XML(res.body)
  text = xml.css('pre').children.text.strip
  csv = CSV.parse(text, {
    col_sep: "\t",
    header_converters: [lambda {|f| f.strip}, :symbol],
    converters: lambda {|f| f ? f.strip : nil },
    headers: true
  })
  check_duplex csv
end

def check_duplex(csv)
  csv.each do |p|
    sizes = p[:size].split
    p[:size] = (sizes - %w(Duplex Simplex)).join ' '
    p[:duplex] = sizes.include? "Duplex"
  end
end

namespace :cthit do
  desc "Update glorious printers"
  task update_printers: :environment do
    csv = get_all_csv
    Printer.where('name NOT IN (?)', csv.map{ |c| c[:printer] })
           .update_all deleted: true

    csv.each do |printer|
      pp = Printer.find_or_initialize_by(name: printer[:printer])
      pp.update_attributes({
        location: printer[:location],
        media: printer[:size],
        duplex: printer[:duplex],
        deleted: false
      })
      puts pp
    end
  end
end
