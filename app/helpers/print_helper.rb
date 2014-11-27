module PrintHelper
	DOMAIN = "remote1.student.chalmers.se"
	SSH_FILENAME = ".print/chalmersit.dat"
	#Called to upload and print a file on a chalmers printer
	def print_script(username, password, filename, printer)
		output = ""
		Net::SSH.start(DOMAIN, username, password: password) do |ssh|
			ssh.scp.upload!(filename, SSH_FILENAME)
			output = ssh.exec! "export CUPS_GSSSERVICENAME=HTTP; /usr/bin/lpr -P #{printer} #{SSH_FILENAME}"
		end
		raise output unless output.nil?
	end
end
