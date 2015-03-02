module Spear
  module Structure
    module Job
      class Search < Structure::Base
        include EmbededClass

        attr_reader :tn_did
        attr_accessor :jobs

        def initialize(response)
          super(response)
          @tn_did = response.request.options[:query][:TalentNetworkDID]

          job_search_result = @root['Results'].nil? ? [] : @root['Results']['JobSearchResult']
          @jobs = generate_jobs(job_search_result, @tn_did)
        end
      end
    end
  end
end
