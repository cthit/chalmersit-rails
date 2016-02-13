module PagesHelper
  def path_to_page(page)
    slug = page.slug
    while !page.parent.nil?
      slug = page.parent.slug + '/' + slug
      page = page.parent
    end
    slug
  end
end
