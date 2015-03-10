module Spear
  module Structure
    module User
      class CheckExisting < Structure::Base
        attr_reader :external_id, :oauth_token, :check_status

        def initialize(response)
          super(response)

          @external_id = @root["ResponseExternalID"]
          @oauth_token = @root["ResponseOAuthToken"]
          @check_status = @root['UserCheckStatus']
        end
      end
    end
  end
end
