require 'fozzie/rails/middleware'
require 'fozzie/rails/engine'

module Fozzie
  class Railtie < ::Rails::Railtie

    @fozzie_railtie_block = Proc.new do |app|
      # Load up the middleware
      app.middleware.use Fozzie::Rails::Middleware
    end

    class << self
      attr_reader :fozzie_railtie_block
    end

    initializer "fozzie_railtie.configure_rails_initialization", &@fozzie_railtie_block

  end
end