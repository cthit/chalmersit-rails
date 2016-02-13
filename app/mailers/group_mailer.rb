class GroupMailer < ApplicationMailer
	default from: 'no-reply@chalmers.it'
  
	def anonymous_mail(recipient, body, title)
		  @body = body
    	  mail(to: recipient, subject: title)
	end
end
