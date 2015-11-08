class PostMailer < ApplicationMailer
	helper ApplicationHelper
	helper PostsHelper
	default from: 'no-reply@chalmers.it'

	def send_newsmail(post)
		@post = post
		mail(to: @post.user.mail, subject: "Chalmers IT: #{@post.title}")
	end
end
