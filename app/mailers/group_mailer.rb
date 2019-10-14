require 'faraday'

class GroupMailer
	@sender_url = 'no-reply@chalmers.it'
  
	def self.anonymous_mail(recipient, body, title)
    for i in recipient
      if i != ""
        link = "http://gotify:8080/mail"
        url = URI.parse(link)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = false
        req = Net::HTTP::Post.new(url.path)
        req.add_field('Content-Type', 'application/json')
        req.add_field('Authorization', 'pre-shared: 123abc')
        req.body = {
          'to' => i,
          'from' => @sender_url,
          'subject' => title,
          'body' => body
        }.to_json
        response = http.request(req)
      end
    end
  end
end
