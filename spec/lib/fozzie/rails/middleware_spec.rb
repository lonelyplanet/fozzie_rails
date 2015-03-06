require 'spec_helper'

# Mock this out for Rails 2
module ActionController::Routing
  class Routes; end
end

module Fozzie::Rails
  describe Middleware do
    subject { Middleware.new({}) }

    describe "#rails_version" do

      it "returns the major version from Rails.version" do
        expect(subject.rails_version).to be_kind_of(Integer)
      end
    end

    describe "#routing_lookup" do

      it "returns ::ActionDispatch::Routing::RouteSet instance for Rails 3 and up" do
        expect(subject.routing_lookup).to be_kind_of(::ActionDispatch::Routing::RouteSet)
      end

      it "returns ActionController::Routing::Routes instance for Rails 2" do
        expect(::Rails).to receive(:version).and_return(2)
        expect(subject.routing_lookup).to eq ::ActionController::Routing::Routes
      end
    end
  end

  describe "#generate_key" do
    let(:env)     { double "env" }
    let(:path)    { double "path" }
    let(:routes)  { double 'routes' }
    subject       { Middleware.new({}) }

    it "gets the path_info and request method from env parameter" do
      expect(env).to receive(:[]).with("PATH_INFO")
      expect(env).to receive(:[]).with("REQUEST_METHOD")

      subject.generate_key(env)
    end

    context "when path_info is nil" do
      let(:env) { { "PATH_INFO" => nil } }

      it "does not lookup routing" do
        expect(subject).to_not receive(:routing_lookup)

        subject.generate_key(env)
      end

      it "does not register any stats" do
        expect(S).to_not receive(:increment)
      end

      it "returns nil" do
        expect(subject.generate_key(env)).to be_nil
      end
    end

    context "when path info is not nil" do
      let(:env) { { "PATH_INFO" => path, "REQUEST_METHOD" => 'generate_key' } }

      before do
        allow(subject).to receive(:routing_lookup).and_return(routes)
        allow(routes).to receive(:recognize_path).and_return({:controller => "controller",:action => "action" })
      end

      it "looks up controller and action for the path and request method" do
        expect(subject).to receive(:routing_lookup).and_return(routes)
        expect(routes).to receive(:recognize_path).with(path, :method => 'generate_key')

        subject.generate_key(env)
      end

      it "returns a bucket generated from the controller, action, and 'render'" do
        expect(subject.generate_key(env)).to eq "controller.action.render"
      end
    end
  end
end
