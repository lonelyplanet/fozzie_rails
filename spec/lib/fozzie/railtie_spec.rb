require 'spec_helper'
require 'rails/engine'
require 'fozzie/railtie'

module Fozzie
  describe Railtie do

    let(:app)         { double("app") }
    let(:middleware)  { double("middleware") }
    let(:routes)      { double("routes") }

    subject { Fozzie::Railtie.fozzie_railtie_block.call(app) }

    context "when rails middleware is enabled" do

      before do
        app.should_receive(:middleware).and_return(middleware)
        middleware.should_receive(:use)
      end

      specify { expect{subject}.not_to raise_error }
    end
  end
end