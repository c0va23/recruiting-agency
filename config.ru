# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

if ENV['AUTH_BASIC_USER'] && ENV['AUTH_BASIC_PASSWORD']
  use Rack::Auth::Basic, 'Recruitment agency' do |user, password|
    user == ENV['AUTH_BASIC_USER'] && password == ENV['AUTH_BASIC_PASSWORD']
  end
end

run Rails.application
