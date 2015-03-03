module Spear
  module Structure
    module Application
      class Create < Structure::Base
        attr_reader :total_results, :returned_results

        attr_accessor :results

        def initialize(response)
          super(response)

          @total_results = @root["TotalResults"]
          @returned_results = @root["ReturnedResults"]
          @results = @root["Results"]
        end
      end
    end
  end
end
