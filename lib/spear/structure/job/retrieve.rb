module Spear
  module Structure
    module Job
      class Retrieve < Structure::Base
        attr_reader :job_id
        attr_accessor :job_description, :job_requirements, :job_title

        def initialize(response)
          super(response)

          if response.kind_of?(HTTParty::Response)
            @job_id = response.request.options[:query][:DID]
          end

          unless @root["Job"].nil?
            @job_description = @root["Job"]["JobDescription"]
            @job_requirements = @root["Job"]["JobRequirements"]
            @job_title = @root["Job"]["JobTitle"]
          end
        end
      end
    end
  end
end
