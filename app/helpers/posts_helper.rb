module PostsHelper
  def show_event_fields?
    not @post.new_record? && @post.event?
  end

  def link_to_committee(post)
    link_to post.group.name, committee_path(post.group)
  end
end
