module ApplicationHelper
  def markdown(content)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter
    ]
    result = pipeline.call(content)
    result[:output].to_s.html_safe
  end

  # Returns true if entity has a translation to _locale_
  def has_translation?(entity, locale = I18n.locale)
    entity.translations.any? { |e| e.locale == locale}
  end

  def header_link_to_current(title, path)
    classes = 'menu-item'
    classes += ' current_page_item' if current_page?(path) || request.fullpath.include?(path)
    content_tag :li, (link_to title, path), class: classes
  end

  def locale_or_nil(locale = I18n.default_locale)
    I18n.locale == locale ? nil : I18n.locale
  end

  def body_classes
    classes = []
    classes << controller.controller_name
    classes << "#{controller.controller_name}-#{action_name}"
    classes << 'logged-in' if signed_in?
    classes.join ' '
  end

  def edit_user_path
    "#{Rails.configuration.account_ip}/me/edit"
  end

  def logout_path(return_to)
    return_to = "?return_to=#{return_to}" if return_to
    "#{Rails.configuration.account_ip}/logout#{return_to}"
  end
end
