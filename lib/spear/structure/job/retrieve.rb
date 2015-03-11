module Spear
  module Structure
    module Job
      class Retrieve < Structure::Base
        attr_reader :job_did
        attr_accessor :job_description, :job_requirements, :job_title, :required_experience, :job_categories

        def initialize(response)
          super(response)

          if response.class == HTTParty::Response
            @job_did = response.request.options[:query][:DID]
          end

          unless @root["Job"].nil?
            @job_title = @root["Job"]["JobTitle"]
            @job_description = @root["Job"]["JobDescription"]
            @job_requirements = @root["Job"]["JobRequirements"]
            @experience_required = @root["Job"]["ExperienceRequired"]
            @job_categories = @root["Job"]["Categories"]
          end
        end
      end
    end
  end
end
