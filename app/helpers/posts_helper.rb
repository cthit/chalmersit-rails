module PostsHelper
  def post_meta post
    body = markdown post.body
    "<meta property=\"og:url\" content=\"#{post_url post}\"/>
    <meta property=\"og:title\" content=\"#{post.title}\"/>
    <meta property=\"og:description\" content=\"#{text_body body}\"/>
    <meta property=\"og:image\" content=\"#{get_first_image body}\"/>"
  end
  #get first image or set default
  def get_first_image body
    html_doc = Nokogiri::HTML.parse(body)
    tag = html_doc.css('img').first
    if tag.nil?
      image = asset_path "logo-dark-txt.png"
    else
      image = tag.attr('src')
    end
    image
  end
  def text_body body
    html_doc = Nokogiri::HTML.parse(body)
    html_doc.text.gsub(/\n+/, " ")
  end
  def show_event_fields?
    @post.event.persisted?
  end

  def link_to_committee(post)
    begin
        link_to post.group.name, committee_path(post.group)
    rescue NoMethodError
        p "Could not find committee for post #{post.to_param}"
        link_to "(Null)", "/"
    end
  end

  def get_previous post
    post.previous current_user
  end

  def get_next post
    post.next current_user
  end
end
