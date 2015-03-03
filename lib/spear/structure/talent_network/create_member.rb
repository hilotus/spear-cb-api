module Spear
  module Structure
    module TalentNetwork
      class CreateMember < Structure::Base
        attr_reader :member_did

        def initialize(response)
          super(response)
          @member_did = @root['MemberDID']
        end

      end
    end
  end
end
