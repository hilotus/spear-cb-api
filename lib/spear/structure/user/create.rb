module Spear
  module Structure
    module User
      class Create < Structure::Base
        attr_reader :external_id

        def initialize(response)
          super(response)

          @external_id = @root["ResponseExternalID"]
        end
      end
    end
  end
end
