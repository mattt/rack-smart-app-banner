# frozen_string_literal: true

require 'uri'

module Rack #:nodoc:
  class SmartAppBanner
    VERSION = '0.1.0'

    def initialize(app, options = {})
      raise ArgumentError, 'App ID Required' unless options[:app_id] &&
                                                    !options[:app_id].empty?
      raise ArgumentError, 'Incomplete Affiliate Information' if (options[:affiliate_partner_id] || options[:affiliate_site_id]) && !(options[:affiliate_partner_id] && options[:affiliate_site_id])
      raise ArgumentError, 'App Argument Must Be Lambda' if options[:app_argument] && !options[:app_argument].lambda?

      @app = app
      @options = options
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
      return [@status, @headers, @response] unless html?

      request = Rack::Request.new(env)
      response = Rack::Response.new([], @status, @headers)
      if @response.respond_to?(:to_ary)
        @response.each do |fragment|
          response.write inject_smart_app_banner(request, fragment)
        end
      end

      response.finish
    end

    private

    def html?
      @headers['Content-Type'] =~ /html/
    end

    def inject_smart_app_banner(request, response)
      parameters = { 'app-id' => @options[:app_id] }
      parameters['affiliate-data'] = "partnerId=#{@options[:affiliate_partner_id]}&siteID=#{@options[:affiliate_site_id]}" if @options[:affiliate_partner_id] && @options[:affiliate_site_id]
      parameters['app-argument'] = @options[:app_argument].call(request) if @options[:app_argument]

      if argument = parameters['app-argument']
        parameters['app-argument'] = "http://#{argument}" unless URI(argument).scheme
      end

      content = parameters.collect { |k, v| "#{k}=#{v}" }.join(', ')

      meta = <<~EOF
        <meta name="apple-itunes-app" content="#{content}" />
      EOF

      response.gsub(%r{</head>}, meta + '</head>')
    end
  end
end
