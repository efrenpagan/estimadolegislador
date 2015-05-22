# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


if Global.config.sendgrid.enabled
	ActionMailer::Base.smtp_settings = {
	  :user_name => ENV['sendgrid_username'],
	  :password => ENV['sendgrid_password'],
	  :domain => 'atentamente.org',
	  :address => 'smtp.sendgrid.net',
	  :port => 587,
	  :authentication => :plain,
	  :enable_starttls_auto => true
	}
else
	ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = { :address => "localhost", :port => 1025 }
end