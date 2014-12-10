module CommitteesHelper
  def strip_http(url)
    url.gsub %r{https?://}, ''
  end
end
