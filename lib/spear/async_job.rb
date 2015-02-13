# encoding: utf-8

module Spear
  class AsyncJob
    include SuckerPunch::Job

    def perform(options={})
      # TODO: save the error to log
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
