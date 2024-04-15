ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Подключение дополнительных библиотек и файлов
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  # Настройка фабрик (если используется FactoryBot)
#   config.include FactoryBot::Syntax::Methods

  # Настройка Devise (если используется Devise)
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request

end