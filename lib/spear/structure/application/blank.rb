module Spear
  module Structure
    module Application
      class Blank < Structure::Base
        attr_reader :job_did, :job_title, :total_questions, :total_required_questions,
                    :application_submit_service_url, :apply_url
        attr_accessor :questions

        def initialize(response)
          super(response)

          blank_application = @root['BlankApplication']

          unless blank_application.nil?
            @job_did = blank_application['JobDID']
            @job_title = blank_application['JobTitle']
            @total_questions = blank_application['TotalQuestions']
            @total_required_questions = blank_application['TotalRequiredQuestions']
            @application_submit_service_url = blank_application['ApplicationSubmitServiceURL']
            @apply_url = blank_application['ApplyURL']

            @questions = generate_questions(blank_application['Questions']['Question'])
          end
        end

        class Question
          attr_accessor :id, :type, :required, :text

          def initialize(id, type, required, text)
            @id = id
            @type = type
            @required = required
            @text = text
          end
        end

        private
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
