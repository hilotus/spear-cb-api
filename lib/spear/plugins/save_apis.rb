# encoding: utf-8

module Spear
  module Plugins
    module SaveApis
      extend ActiveSupport::Concern

      included do
        class_attribute :api_response, :api_started_at, :api_async_job

        before_execute :record_started_time
        after_execute :save_infos
      end

      def record_started_time
        self.api_started_at = Time.now
      end

      def save_infos
        self.api_async_job ||= AsyncSaveApi.new

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

        self.api_async_job.async.perform(params)
      end

      class AsyncSaveApi
        include SuckerPunch::Job
        workers 4

        def perform(options={})
          HTTParty.post(
            %q{http://ciws.hilotus.com/api/v1/api-info},
            body: {
              project:  options[:project],
              url:      options[:url],
              method:   options[:method],
              request:  options[:request],
              response: options[:response],
              duration: options[:duration] }.to_json,
            options: {headers: {'Content-Type' => 'application/json'}}
          ) rescue nil
        end

        # def later(sec, data)
        #   after(sec) { perform(data) }
        # end
      end

    end
  end
end
