require 'net/http'
namespace :cthit do
  desc "Update glorious printers"
  task update_printers: :environment do
    uri = URI('http://print.chalmers.se/public/pls.cgi')
    res = Net::HTTP.post_form(uri, 'textver' => 'CSV export')
    lines = res.body.split("\n")
    lines.drop(12).each do |printer|
      values = printer.split("\t")
      
      next unless values.length == 6

      p = Printer.create(name: values[0].strip, location: values[2].strip, media: values[4].strip)
      puts p
    end

  end

end