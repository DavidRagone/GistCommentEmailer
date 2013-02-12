# Load the rails application
require File.expand_path('../application', __FILE__)

env_vars = File.join(Rails.root, 'config', 'env_vars.rb')
load(env_vars) if File.exists?(env_vars)

# Initialize the rails application
GistCommentEmailer::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 25,
  domain: "gmail.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: ENV['GMAIL_USERNAME'],
  password: ENV['GMAIL_PASSWORD']
}
