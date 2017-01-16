module PostsHelper
  def post_meta post
    body = markdown post.body
    "<meta property=\"og:url\" content=\"#{post_url post}\"/>
    <meta property=\"og:title\" content=\"#{post.title}\"/>
    <meta property=\"og:description\" content=\"#{first_paragraph body}\"/>
    <meta property=\"og:image\" content=\"#{get_first_image body}\"/>"
  end
  #get first image or set default
  def get_first_image body
    image = body[/img.*?src="(.*?)"/i,1]
    if image.nil?
      image = asset_path "logo-dark-txt.png"
    end
    image
  end
  def first_paragraph body
    body[/<p>(.*)<\/p>/i,1]
  end
  def show_event_fields?
    not @post.new_record? && @post.event?
  end

  def link_to_committee(post)
    link_to post.group.name, committee_path(post.group)
  end
end
