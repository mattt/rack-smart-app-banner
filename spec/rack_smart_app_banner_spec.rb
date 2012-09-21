require "minitest/autorun"
require "minitest/pride"
require "rack"
require "rack/lint"
require "rack/mock"
require "rack/smart-app-banner"

describe Rack::SmartAppBanner do
  let(:html_file) do
    File.read(File.expand_path("../fixtures/test.html", __FILE__))
  end
  let(:html_app)     { proc{[200,{"Content-Type"=>"text/html"},[html_file]]} }
  let(:text_app)     { proc{[200,{"Content-Type"=>"text/plain"},["TEXT"]]} }
  let(:typekit_html) { Rack::SmartAppBanner.new(html_app, :app_id => "123456789") }
  let(:typekit_text) { Rack::SmartAppBanner.new(text_app, :app_id => "123456789") }

  it { proc{ Rack::SmartAppBanner.new(nil) }.must_raise(ArgumentError) }

  it { typekit_html.must_be_kind_of(Rack::SmartAppBanner) }
  it { typekit_text.must_be_kind_of(Rack::SmartAppBanner) }

  describe "script injection" do
    describe "html" do
      let(:request)  { Rack::MockRequest.new(Rack::Lint.new(typekit_html)) }
      let(:response) { request.get("/") }

      it { response.status.must_equal 200 }
      it { response.body.must_match %(<meta name="apple-itunes-app" content="app-id=123456789" />) }
      it { response.body.must_match "<title>Rack::SmartAppBanner Test</title>" }
      it { response.body.must_match "<p>HTML</p>" }
    end

    describe "text" do
      let(:request)  { Rack::MockRequest.new(Rack::Lint.new(typekit_text)) }
      let(:response) { request.get("/") }

      it { response.status.must_equal 200 }
      it { response.body.wont_match %(<meta name="apple-itunes-app" content="app-id=123456789" />) }
      it { response.body.must_match "TEXT" }
    end
  end
end
