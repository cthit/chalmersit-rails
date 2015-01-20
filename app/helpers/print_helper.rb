module PrintHelper
  DOMAIN = "remote1.student.chalmers.se"
  SSH_FILENAME = ".print/chalmersit.dat"
  #Called to upload and print a file on a chalmers printer
  def print_script(print)
    output = nil
    Net::SSH.start(DOMAIN, print.username, password: print.password) do |ssh|
      ssh.scp.upload!(print.file.path, SSH_FILENAME)
      output = ssh.exec! print_string(print)
    end
    raise output unless output.nil?
  end

  def print_string(print)
    return "export CUPS_GSSSERVICENAME=HTTP; #{print} #{SSH_FILENAME}"
  end
end
