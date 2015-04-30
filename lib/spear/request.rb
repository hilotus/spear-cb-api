require 'active_model'
require 'active_model/callbacks'

module Spear
  class Request
    include HTTParty
    extend ActiveModel::Callbacks

    # httparty perference
    default_timeout Spear.time_out

    # callback
    define_model_callbacks :execute, :only => [:before, :after]

    attr_accessor :method, :query, :body, :url

    # params: {:body => {}, :query => {}}
    def initialize(method, endpoint, params={})
      @method = method
      @query = params[:query] || {}
      @body = params[:body] || {}
      @header = params[:header] || {}
      @api_options = params[:api_options] || {}
      @url = Spear.base_uri + endpoint
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
            self.class.get(@url, query: splice_query)
          when :post
            self.class.post(@url, body: splice_body, query: @query)
          when :upload_file
            self.class.post(@url, body: @body, query: splice_query)
          when :parse_file
            self.class.post(@url, body: splice_body)
          when :apply
            self.class.post(@url, body: to_xml(@body), headers: splice_header)
          else
            raise Spear::ParametersNotValid.new("#{method} is not support.")
          end
        rescue SocketError => e  # if the network is disconnected, it'll throw SocketError.
          raise Spear::NetworkError.new(e.message)
        rescue Timeout::Error => e
          raise Spear::TimeoutError.new(e.message)
        end
      end

      # splice request body
      def splice_body
        @body[:DeveloperKey] = Spear.dev_key

        if need_test_element?
          @body[:Test] = @api_options[:test_element].nil? ? Spear.use_test? : @api_options[:test_element]
        end

        to_xml(@body)
      end

      # parse body from hash to xml format
      def to_xml(body)
        root = @api_options[:root_element].nil? ? 'Request' : @api_options[:root_element]
        body.to_xml(root: root, skip_instruct: true, skip_types: true)
      end

      # splice query(url params) {:query => {}} with DeveloperKey and Test
      def splice_query
        @query[:DeveloperKey] = Spear.dev_key

        if need_test_element?
          @query[:Test] = @api_options[:test_element].nil? ? Spear.use_test? : @api_options[:test_element]
        end

        @query
      end

      def splice_header
        @header[:DeveloperKey] = Spear.dev_key
      end

      # some api need Test element.
      def need_test_element?
        @api_options[:need_test_element].nil? ? true : @api_options[:need_test_element]
      end

  end
end
