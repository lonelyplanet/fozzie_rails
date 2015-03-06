require 'spec_helper'

module Fozzie::Rails
  describe Railtie do

    it "is loaded when Rails exists" do
      expect(Application.middleware.middlewares).to include(Fozzie::Rails::Middleware)
    end
  end
end
