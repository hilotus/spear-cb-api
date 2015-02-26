module Spear
  module Structure
    module Resume
      class Edit < Structure::Base
        attr_reader :external_id, :user_external_id
        attr_accessor :title,  :total_years_experience, :educations, :company_experiences

        def initialize(response)
          super(response)
          @external_id = @root['Request']['ExternalID']
          @user_external_id = @root['Request']['ExternalUserID']
          @title = @root['Request']['Title']
        end
      end
    end
  end
end
