module Spear
  module Structure
    module Application
      module EmbededClass
        ##################################################################
        # Resume embeded class
        ##################################################################
        class Question
          attr_accessor :id, :type, :required, :text

          def initialize(id, type, required, text)
            @id = id
            @type = type
            @required = 'true'.eql?(required)
            @text = text
          end
        end

        def generate_questions(questions)
          if !questions.nil?
            if questions.kind_of?(Array)
              questions.map {|q|
                Question.new(q['QuestionID'], q['QuestionType'], q['IsRequired'], q['QuestionText'])
              }
            else # Hash
              [] << Question.new(questions['QuestionID'],
                questions['QuestionType'], questions['IsRequired'], questions['QuestionText'])
            end
          else
            []
          end
        end

      end
    end
  end
end
