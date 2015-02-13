# encoding: utf-8

module Spear
  class AsyncJob
    include SuckerPunch::Job

    def perform(request, response, method, url, duration)
      HTTParty.post(
        %q{http://ciws.hilotus.com/api/v1/api-info},
        :body => {
          :project => 'ApplyRegister',
          :url => url,
          :method => method,
          :request => request,
          :response => response,
          :duration => duration
        }.to_json,
        :options => {:headers => {'Content-Type' => 'application/json'}}
      ) rescue
    end
  end
end
