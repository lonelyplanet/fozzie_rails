require 'fozzie/rails/middleware'

module Fozzie
  module Rails
    class Railtie < ::Rails::Railtie

      initializer "fozzie_railtie.configure_rails_initialization" do |app|
        app.middleware.use Fozzie::Rails::Middleware
      end

    end
  end
end