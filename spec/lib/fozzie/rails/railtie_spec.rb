require 'spec_helper'

module Fozzie::Rails
  describe Railtie do

    it "is loaded when Rails exists" do
      Application.middleware.middlewares.should include(Fozzie::Rails::Middleware)
    end
  end
end