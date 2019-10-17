class GotifyMailer
	@sender_mail = 'no-reply@chalmers.it'
  @psk = ENV['GOTIFY_PRE_SHARED_KEY']
  @url = URI.parse("#{ENV['GOTIFY_API_URL']}/mail")
  
  def self.anonymous_mail(recipient, body, title)
    http = Net::HTTP.new(@url.host, @url.port)
    http.use_ssl = false
    for i in recipient
      if i != ""
        req = Net::HTTP::Post.new(@url.path)
        req.add_field('Content-Type', 'application/json')
        req.add_field('Authorization', "pre-shared: #{@psk}")
        req.body = {
          'to' => i,
          'from' => @sender_mail,
          'subject' => title,
          'body' => body
        }.to_json
        response = http.request(req)
      end
    end
  end
end
