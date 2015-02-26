module Spear
  module Structure
    module Resume
      class Ownall < Structure::Base
        attr_reader :resumes

        def initialize(response)
          super(response)
          @resumes = extract_resume(@root['Resumes'])
        end

        private
          def extract_resume(resumes, list=[])
            unless resumes.nil?
              if resumes['Resume'].kind_of?(Array)
                resumes['Resume'].each do |resume|
                  list << resume
                end
              elsif resumes['Resume'].kind_of?(Hash)
                list << resumes['Resume']
              end
            end
            list
          end
      end
    end
  end
end
