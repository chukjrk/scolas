# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
# 	address:				'smtp.sendgrid.net',
# 	port:					'587',
# 	:authentication			=> :plain,
# 	user_name:				'app46489353@heroku.com',
# 	password: 				'j7vb8nip9824',
#     domain: 				'scolas.herokuapp.com',
#     enable_starttls_auto: true
# }

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :port           => '25', # or 2525
  :address        => ENV['POSTMARK_SMTP_SERVER'],
  :user_name      => ENV['POSTMARK_API_TOKEN'],
  :password       => ENV['POSTMARK_API_TOKEN'],
  :domain         => 'scolas.herokuapp.com',
  :authentication => :cram_md5, # or :plain for plain-text authentication
  :enable_starttls_auto => true, # or false for unencrypted connection
}

# if Rails.env != 'test'
#   email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
#   ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
# end

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
# 	address:				'smtp-relay.sendinblue.com',
# 	port:					'587',
# 	:authentication			=> :plain,
# 	user_name:				'cjkemdirim@gmail.com',
# 	password: 				'DI4SLxEq8WTNVARO',
#     domain: 				'scolas.herokuapp.com',
#     enable_starttls_auto: true
# }