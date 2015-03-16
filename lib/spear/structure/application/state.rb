module Spear
  module Structure
    module Application
      class State < Structure::Base
        include EmbededClass

        attr_accessor :applications

        def initialize(response)
          super(response)

          @applications = generate_apps(@root['ApplicationList']['Application']) rescue nil
        end
      end

    end
  end
end
