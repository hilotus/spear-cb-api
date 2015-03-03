require 'active_model'
require 'active_model/callbacks'

module Spear
  class Request
    extend ActiveModel::Callbacks
    define_model_callbacks :execute, :only => [:before, :after]

    attr_accessor :method, :query, :body, :api_options, :url

    # params: {:body => {}, :query => {}, :api_options => {}}
    #   exp: api_options: {:path => "/v1"}
    def initialize(method, endpoint, params={})
      @method = method
      @query = params[:query] || {}
      @body = params[:body] || {}
      @api_options = params[:api_options] || {}
      @url = generate_resource + endpoint
    end

    def execute
      run_callbacks(:execute) {
        response = exec
        begin
          self.api_response = response
        rescue NoMethodError => e  # if we don't use save api info plugin, it'll throw NoMethodError.
          response
        end
      }
    end

    private
      def exec
        begin
          case @method
          when :get
            HTTParty.get(@url, query: splice_query)
          when :post
            HTTParty.post(@url, body: splice_body, query: @query)
          when :upload_file
            HTTParty.post(@url, body: @body, query: splice_query)
          when :parse_file
            HTTParty.post(@url, body: splice_body)
          when :apply
            HTTParty.post(@url, body: to_xml(@body), query: splice_query)
          else
            raise Spear::ParametersNotValid.new("#{method} is not support.")
          end
        rescue SocketError => e  # if the network is disconnected, it'll throw SocketError.
          raise Spear::NetworkError.new(e.message)
        end
      end

      # generate cb api host and version
      def generate_resource
        uri = URI("")
        uri.scheme = Spear.ssh? ? 'https' : 'http'
        uri.host = Spear.hostname
        uri.port = Spear.port

        # Some api endpoint have no version and fixed pattern.
        if @api_options[:path].nil?
          uri.path = "/#{Spear.version}"
        else
          uri.path = "#{@api_options[:path]}"
        end

        uri.to_s
      end

      # splice request body
      def splice_body
        @body[:DeveloperKey] = Spear.dev_key
        @body[:Test] = Spear.test? if need_test_key?
        to_xml(@body)
      end

      # parse body from hash to xml format
      def to_xml(body)
        body.to_xml(root: 'Request', skip_instruct: true, skip_types: true)
      end

      # splice query(url params) {:query => {}} with DeveloperKey and Test
      def splice_query
        @query[:DeveloperKey] = Spear.dev_key
        @query[:Test] = Spear.test?  if need_test_key?
        @query
      end

      def need_test_key?
        @api_options[:need_test_key].nil? ? true : @api_options[:need_test_key]
      end

  end
end
