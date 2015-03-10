module Spear
  module Structure
    module Job
      class Search < Structure::Base
        include EmbededClass

        attr_reader :tn_did
        attr_accessor :jobs

        def initialize(response)
          super(response)

          if response.class == HTTParty::Response
            @tn_did = response.request.options[:query][:TalentNetworkDID]
          end

          job_search_result = @root['Results'].nil? ? [] : @root['Results']['JobSearchResult']
          @jobs = generate_jobs(job_search_result, @tn_did)
        end
      end
    end
  end
end
