module Spear
  module Structure
    module User
      class TokenAuthenticate < Structure::Base
        attr_reader :token_authentication_url

        def initialize(response)
          super(response)
          @token_authentication_url = @root['TokenAuthenticationUrl']
        end
      end
    end
  end
end
