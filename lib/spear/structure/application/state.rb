module Spear
  module Structure
    module Application
      class State < Structure::Base
        attr_accessor :application_list

        def initialize(response)
          super(response)
          @application_list = @root['ApplicationList']
        end
      end
    end
  end
end
