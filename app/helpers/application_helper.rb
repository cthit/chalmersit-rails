module ApplicationHelper
	def markdown(content)
		GitHub::Markdown.render_gfm(content).html_safe
	end
end
