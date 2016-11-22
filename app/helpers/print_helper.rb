module PrintHelper
  DOMAINS = ['remote11.chalmers.se', 'remote12.chalmers.se']
  SSH_FILENAME = '.print/chalmersit.dat'

  PQ_SITE = 'https://print.chalmers.se/auth/fs.pl'
  XPATH = '//td/b'

  # Called to upload and print a file on a chalmers printer
  def print_script(print)
    output = nil
    DOMAINS.shuffle.each do |d|
      output = connect(print, d)
      break if output.nil?
    end
    raise output unless output.nil?
  end

  def connect(print, domain)
    Net::SSH.start(domain, print.username, password: print.password, number_of_password_prompts: 0, timeout: 10) do |ssh|
      ssh.scp.upload!(print.file.path, SSH_FILENAME)
      ssh.exec! print_string(print)
    end
  end

  def print_string(print)
    return "export CUPS_GSSSERVICENAME=HTTP; #{print} #{SSH_FILENAME}"
  end

  def print_pq(user, pass)
    uri = URI(PQ_SITE)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth user, pass

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end
    return { error: res.message } if res.code == '401'
    doc = Nokogiri::HTML(res.body)
    b = doc.xpath(XPATH).last
    { value: b.inner_text.squish, username: user }
  end
end
