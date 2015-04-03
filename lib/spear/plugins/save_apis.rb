# encoding: utf-8

module Spear
  module Plugins
    module SaveApis
      extend ActiveSupport::Concern

      included do
        class_attribute :api_response, :api_started_at

        before_execute :record_started_time
        after_execute :save_infos
      end

      def record_started_time
        self.api_started_at = Time.now
      end

      def save_infos
        params = {
          project: Spear.project,
          request: nil,
          response: self.api_response.body,
          method: self.api_response.request.http_method.to_s.split('::').last,
          url: self.api_response.request.path.to_s,
          duration: ((Time.now - self.api_started_at).to_f * 1000.0).to_i
        }

        params[:request] = self.api_response.request.options[:body] || self.api_response.request.options[:query]
        if params[:request].kind_of?(String)
            # parse file api
            params[:request].gsub!(/<FileBytes>(.*?)<\/FileBytes>/m, '<FileBytes>...</FileBytes>')
            # apply job api
            params[:request].gsub!(/<ResumeData>(.*?)<\/ResumeData>/m, '<ResumeData>...</ResumeData>')
        elsif params[:request].kind_of?(Hash)
          # upload file api
          params[:request][:FileBytes] = '...'
        end

        AsyncSaveApi.new.async.perform(params)
      end

      class AsyncSaveApi
        include HTTParty
        include SuckerPunch::Job
        workers 4

        def perform(options={})
          self.class.post(
            'http://eventlogs.cb-apac.com/api/1/api-info',
            body: options.to_json,
            options: {headers: {'Content-Type' => 'application/json'}}
          )
        end

        # def later(sec, data)
        #   after(sec) { perform(data) }
        # end
      end

    end
  end
end
