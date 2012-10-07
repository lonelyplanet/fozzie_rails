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
        subject.rails_version.should be_kind_of(Integer)
      end
    end

    describe "#routing_lookup" do

      it "returns ::ActionDispatch::Routing::RouteSet instance for Rails 3 and up" do
        subject.routing_lookup.should be_kind_of(::ActionDispatch::Routing::RouteSet)
      end

      it "returns ActionController::Routing::Routes instance for Rails 2" do
        ::Rails.should_receive(:version).and_return(2)
        subject.routing_lookup.should eq ::ActionController::Routing::Routes
      end
    end
  end

  describe "#generate_key" do
    let(:env)     { mock "env" }
    let(:path)    { mock "path" }
    let(:routes)  { mock 'routes' }
    subject       { Middleware.new({}) }

    it "gets the path_info and request method from env parameter" do
      env.should_receive(:[]).with("PATH_INFO")
      env.should_receive(:[]).with("REQUEST_METHOD")

      subject.generate_key(env)
    end

    context "when path_info is nil" do
      let(:env) { { "PATH_INFO" => nil } }

      it "does not lookup routing" do
        subject.should_receive(:routing_lookup).never

        subject.generate_key(env)
      end

      it "does not register any stats" do
        S.should_receive(:increment).never
      end

      it "returns nil" do
        subject.generate_key(env).should be_nil
      end
    end

    context "when path info is not nil" do
      let(:env) { { "PATH_INFO" => path, "REQUEST_METHOD" => 'generate_key' } }

      before do
        subject.stub(:routing_lookup => routes)
        routes.stub(:recognize_path => {:controller => "controller",:action => "action" })
      end

      it "looks up controller and action for the path and request method" do
        subject.should_receive(:routing_lookup).and_return(routes)
        routes.should_receive(:recognize_path).with(path, :method => 'generate_key')

        subject.generate_key(env)
      end

      it "returns a bucket generated from the controller, action, and 'render'" do
        subject.generate_key(env).should eq "controller.action.render"
      end
    end
  end
end