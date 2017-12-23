ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:        'smtp.sendgrid.net',
  port:           '2525',
  authentication: :plain,
  user_name:      ENV['app83475636@heroku.com'],
  password:       ENV['zz9huds98461'],
  domain:         'heroku.com',
  enable_starttls_auto: true
}
