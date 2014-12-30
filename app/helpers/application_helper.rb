module ApplicationHelper
  def markdown(content)
    GitHub::Markdown.render_gfm(content).html_safe
  end

  # Returns true if entity has a translation to _locale_
  def has_translation?(entity, locale=I18n.locale)
    not entity.translations.index { |p| p.locale == locale}.nil?
  end

  def header_link_to_current(title, path)
    classes = 'menu-item'
    classes += ' current_page_item' if current_page? path
    content_tag :li, (link_to title, path), class: classes
  end

  def locale_or_nil(locale = I18n.default_locale)
    I18n.locale == locale ? nil : I18n.locale
  end
end
