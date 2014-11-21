module TwitterHelper
  def twitter_feed(username)
    $twitter.user_timeline(username).map do |t|
      format_tweet(t)
    end
  end

  def format_tweet(tweet)
    text = tweet.text.dup
    tweet.hashtags.each do |tag|
      text.sub! "\##{tag.text}", "<a href=\"http://twitter.com/search?q=#{tag.text}&src=hash\">\##{tag.text}</a>"
    end
    tweet.uris.each do |uri|
      text.sub! "#{uri.url}", "<a href=\"#{uri.expanded_url}\">#{uri.display_url}</a>"
    end
    tweet.user_mentions.each do |user|
      text.sub! "@#{user.screen_name}", "<a href=\"http://twitter.com/#{user.screen_name}\" title=\"#{user.name}\">@#{user.screen_name}</a>"
    end
    text.html_safe
  end
end
