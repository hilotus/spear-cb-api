module Spear
  module Structure
    module TalentNetwork
      class JoinFormQuestion < Structure::Base
        include EmbededClass

        attr_accessor :join_questions

        def initialize(response)
          super(response)
          @join_questions = generate_questions(@root["JoinQuestions"])
        end

      end
    end
  end
end
