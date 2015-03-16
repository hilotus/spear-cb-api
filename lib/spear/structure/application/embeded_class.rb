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

        class ApplicationObject
          attr_accessor :app_did, :is_viewed, :view_date

          def initialize(app_did, is_viewed, view_date)
            @app_did = app_did
            @is_viewed = 'true'.eql?(is_viewed)
            @view_date = view_date unless view_date.blank?
          end
        end

        def generate_apps(apps)
          if !apps.nil?
            if apps.kind_of?(Array)
              apps.map {|app|
                ApplicationObject.new(app['ApplicationDID'], app['Viewed'], app['ViewedDate'])
              }
            else # Hash
              [] << ApplicationObject.new(apps['ApplicationDID'], apps['Viewed'], apps['ViewedDate'])
            end
          else
            []
          end
        end

      end
    end
  end
end
