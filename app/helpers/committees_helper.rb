module CommitteesHelper
  def strip_http(url)
    url.gsub %r{https?://}, ''
  end

  def filter_committees(user)
    @committees.select do |c|
      user.groups.items.include?(c.slug)
    end
  end
end
