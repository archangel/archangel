# frozen_string_literal: true

require 'highline/import'

def prompt_for_admin_email
  ENV.fetch('ADMIN_EMAIL') do
    ask('Email address: ') { |question| question.default = 'me@example.com' }
  end
end

def prompt_for_admin_first_name
  ENV.fetch('ADMIN_FIRST_NAME') do
    ask('First Name: ') { |question| question.default = 'Admin' }
  end
end

def prompt_for_admin_last_name
  ENV.fetch('ADMIN_LAST_NAME') do
    ask('Last Name: ') { |question| question.default = 'User' }
  end
end

def prompt_for_admin_username
  ENV.fetch('ADMIN_USERNAME') do
    ask('Username: ') { |question| question.default = 'administrator' }
  end
end

def prompt_for_admin_password
  ENV.fetch('ADMIN_PASSWORD') do
    ask('Password: ') { |question| question.echo = '*' }
  end
end

# Timestamp
now = Time.current

# Site
site = Site.find_or_create_by(subdomain: 'archangel') do |item|
  item.name = 'Archangel'
end

# User (admin)
user = User.find_or_create_by(email: prompt_for_admin_email, username: prompt_for_admin_username) do |item|
  first_name = prompt_for_admin_first_name
  last_name = prompt_for_admin_last_name
  password = prompt_for_admin_password

  item.first_name = first_name
  item.last_name = last_name
  item.password = password
  item.password_confirmation = password
  item.confirmed_at = now
end

# UserSite
UserSite.find_or_create_by(site_id: site.id, user_id: user.id) do |item|
  item.role = 0
end

# Content
Content.where(site_id: site.id, slug: 'sample').first_or_create do |item|
  item.name = 'Sample Content'
  item.body = '<p>Body of the content</p>'
  item.published_at = now
end

# Done
say('Insemination complete')
