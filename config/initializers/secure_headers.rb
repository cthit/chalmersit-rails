SecureHeaders::Configuration.default do |config|
  config.csp = {
    script_src: %w('self'),
    style_src: %w('self' https: fonts.googleapis.com),
    font_src: %w(https: fonts.googleapis.com 'self'),
    default_src: Rails.env.production? ? %w(https: 'self') : %w('self')
  }
end
