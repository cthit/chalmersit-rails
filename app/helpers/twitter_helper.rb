module TwitterHelper
  def twitter_feed(username, options = {})
    $twitter.user_timeline(username, options).map do |t|
      { html: format_tweet(t), tweet: t }
    end
  end

  private

    URLS = {
      'Twitter::Entity::Hashtag' => -> (tag) { "<a href=\"http://twitter.com/search?q=#{tag.text}&src=hash\">\##{tag.text}</a>" },
      'Twitter::Entity::URI' => -> (uri) { "<a href=\"#{uri.expanded_url}\">#{uri.display_url}</a>" },
      'Twitter::Entity::UserMention' => -> (user) { "<a href=\"http://twitter.com/#{user.screen_name}\" title=\"#{user.name}\">@#{user.screen_name}</a>" }
    }

    def format_tweet(tweet)
      text = tweet.text.dup

      replaces = tweet.hashtags + tweet.uris + tweet.user_mentions
      replaces.sort_by{ |r| -r.indices[0] }.each do |r|
        text[(r.indices[0])...(r.indices[1])] = URLS[r.class.to_s].call(r)
      end
      text.html_safe
    end
end
