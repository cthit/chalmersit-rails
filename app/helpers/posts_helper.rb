module PostsHelper
  def show_event_fields?
    not @post.new_record? && @post.event?
  end
end
