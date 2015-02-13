module Spear
  class Request
    attr_reader :client, :resource

    def initialize(options={})
      @client = options[:client]
      @resource = resource
      @async_job = Spear::AsyncJob.new
    end

    # TODO: custom reqeust headers support.
    # payload: {:body => {}, :query => {}}
    def execute(http_method, endpoint, payload={})
      start_time = Time.now;
      url = @resource + endpoint;

      case http_method
      when :get
        req = splice(payload)
        resp = HTTParty.get(url, req)
      when :post
        req = {:body => to_xml(payload)}
        resp = HTTParty.post(url, req)
      when :upload_file
        req = splice(payload)
        req[:body] = "file base64 content..."
        resp = HTTParty.post(url, splice(payload))
      when :parse_file
        req = {:body => payload}
        req[:body][:FileBytes] = nil
        resp = HTTParty.post(url, :body => to_xml(payload))
      else
        resp = {"Errors" => {"Error" => "%q{#{http_method} http method is not support.}"}}
      end

      if @client.save_api?
        options = {
          project: @client.project,
          request: req,
          response: resp.to_h,
          method: http_method.to_s,
          url: url,
          duration: ((Time.now - start_time).to_f * 1000.0).to_i
        }
        @async_job.async.perform(options)
      end

      resp
    end

    private
      def resource
        uri = URI("")
        uri.scheme = @client.ssh? ? 'https' : 'http'
        uri.host = @client.hostname
        uri.port = @client.port
        uri.path = "/#{@client.version}"
        uri.to_s
      end

      # parse payload to xml format
      def to_xml(payload)
        payload[:DeveloperKey] = @client.dev_key
        payload[:Test] = @client.test?
        payload = payload.to_xml(root: 'Request', skip_instruct: true, skip_types: true)
      end

      # splice payload {:body => {}, :query => {}} with DeveloperKey and Test
      def splice(payload)
        payload[:query][:DeveloperKey] = @client.dev_key
        payload[:query][:Test] = @client.test?
        payload
      end

  end
end
