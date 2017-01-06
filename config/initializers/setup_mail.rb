ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	address:				'smtp.sendgrid.net',
	port:					'587',
	:authentication			=> :plain,
	user_name:				'app46489353@heroku.com',
	password: 				'j7vb8nip9824',
    domain: 				'schlas.com',
    enable_starttls_auto: true
}