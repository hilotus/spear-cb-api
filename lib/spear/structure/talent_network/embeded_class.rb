module Spear
  module Structure
    module TalentNetwork
      module EmbededClass
        ##################################################################
        # Resume embeded class
        ##################################################################
        class JoinQuestion
          attr_accessor :text, :required, :form_value, :option_display_type, :order, :options

          def initialize(question)
            @text = question['Text']
            @required = question['Required']
            @form_value = question['FormValue']
            @option_display_type = question['OptionDisplayType']
            @order = question['Order']
            @options = question['Options']
          end
        end

        def generate_questions(questions)
          if !questions.nil?
            if questions.kind_of?(Array)
              questions.map {|question| JoinQuestion.new(question)}
            else  # Hash
              [JoinQuestion.new(questions)]
            end
          else
            []
          end
        end

      end
    end
  end
end
