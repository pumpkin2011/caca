Rails.application.configure do
  config.action_mailer.default_url_options = { host: ENV['MAILER_DEFAULT_URL']}
  config.action_mailer.default_options = {
    from:     ENV['MAILER_DEFAULT_FROM'],
    reply_to: ENV['MAILER_DEFAULT_REPLY']
  }
  config.action_mailer.delivery_method = ENV['MAILER_DELIVERY_METHOD'].to_sym
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default charset: 'utf-8'

  config.action_mailer.smtp_settings = {
    address:        'smtp.exmail.qq.com',
    port:           25,
    user_name:      ENV['MAILER_SMTP_USERNAME'],
    password:       ENV['MAILER_SMTP_PASSWORD'],
    authentication: :login,
    enable_starttls_auto: true
  }
end
