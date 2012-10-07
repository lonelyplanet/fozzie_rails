$:.unshift File.expand_path('lib')

require 'rails/all'

module Fozzie
  module Rails
    class Application < ::Rails::Application; end
  end
end

Fozzie::Rails::Application.configure do
  config.active_support.deprecation = :log
end

require 'fozzie_rails'

RSpec.configure do |config|
  config.order = :random
  config.before(:suite) { Fozzie::Rails::Application.initialize! }
end