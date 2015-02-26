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
          @jobs = generate_jobs(@root['Results']['JobSearchResult'], @tn_did)
        end
      end
    end
  end
end
