# encoding: utf-8

module Spear
  class Client
    include Spear::Resource::User
    include Spear::Resource::Resume

    attr_reader :options, :request

    def initialize(options={})
      raise 'DeveloperKey is missing!' if options[:dev_key].nil?
      @options = options
      @request = generate_request
    end

    def test?
      @options[:use_test] || false
    end

    # use https or http
    def ssh?
      @options[:use_ssh] || true
    end

    def hostname
      @options[:hostname] || 'api.careerbuilder.com'
    end

    def port
      @options[:port] || 443
    end

    def version
      @options[:version] || "v2"
    end

    def dev_key
      @options[:dev_key]
    end

    # need save api info
    def save_api?
      @options[:use_saving_api] || false
    end

    private
      def generate_request(options={})
        options = {:client => self}.merge(options)
        return Spear::Request.new(options)
      end
  end
end
