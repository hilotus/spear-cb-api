# encoding: utf-8

module Spear
  module Plugins
    module SaveApis
      extend ActiveSupport::Concern

      included do
        class_attribute :api_response, :api_started_at, :save_api_instance

        before_execute :record_started_time
        after_execute :save_infos
      end

      def record_started_time
        self.api_started_at = Time.now
      end

      def save_infos
        self.save_api_instance ||= AsyncSaveApi.new

        params = {
          project: Spear.project,
          request: nil,
          response: self.api_response.body,
          method: self.api_response.request.http_method.to_s.split('::').last,
          url: self.api_response.request.path.to_s,
          duration: ((Time.now - self.api_started_at).to_f * 1000.0).to_i
        }

        params[:request] = self.api_response.request.options[:body]
        if params[:request].kind_of?(String)
          # parse file api
          params[:request].gsub!(/<FileBytes>(.*?)<\/FileBytes>/m, '<FileBytes>...</FileBytes>')
        elsif params[:request].kind_of?(Hash)
          # upload file api
          params[:request][:FileBytes] = '...'
        end

        self.save_api_instance.async.perform(params)
      end

      class AsyncSaveApi
        include SuckerPunch::Job

        def perform(options={})
          HTTParty.post(
            %q{http://ciws.hilotus.com/api/v1/api-info},
            :body => {
              :project => options[:project],
              :url => options[:url],
              :method => options[:method],
              :request => options[:request],
              :response => options[:response],
              :duration => options[:duration]
            }.to_json,
            :options => {:headers => {'Content-Type' => 'application/json'}}
          ) rescue options
        end
      end

    end
  end
end
