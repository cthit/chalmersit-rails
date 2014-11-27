xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Informationsteknik på Chalmers"
    xml.description ""
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description { xml.cdata! markdown(post.body) }
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end