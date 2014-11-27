module PrintHelper
  DOMAIN = "remote1.student.chalmers.se"
  SSH_FILENAME = ".print/chalmersit.dat"
  #Called to upload and print a file on a chalmers printer
  def print_script(username, password, filename, printer, copies, options = {})
    output = nil
    Net::SSH.start(DOMAIN, username, password: password) do |ssh|
      ssh.scp.upload!(filename, SSH_FILENAME)
      puts "export CUPS_GSSSERVICENAME=HTTP; /usr/bin/lpr -P #{printer} -\# #{copies} #{stringify_options(options)} #{SSH_FILENAME}"
      output = ssh.exec! "export CUPS_GSSSERVICENAME=HTTP; /usr/bin/lpr -P #{printer} -\# #{copies} #{stringify_options(options)} #{SSH_FILENAME}"
    end
    raise output unless output.nil?
  end

  def stringify_options(options)
    str_options = []
    options.each do |k, v|
      str_options << "-o #{k}=#{v}"
    end
    str_options.join ' '
  end


end
