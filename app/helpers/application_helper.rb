module ApplicationHelper
  def markdown(content)
    GitHub::Markdown.render_gfm(content).html_safe
  end

  # Returns true if entity has a translation to _locale_
  def has_translation?(entity, locale=I18n.locale)
    not entity.translations.index { |p| p.locale == locale}.nil?
  end
end
