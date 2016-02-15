module PagesHelper
  def path_to_page(page)
    unless page.parent.nil?
      path_to_page(page.parent) + '/' + page.slug
    else
      root_url + page.slug
    end
  end
end
