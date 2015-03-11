module Spear
  module Structure
    module Resume
      class Retrieve < Structure::Base
        include EmbededClass

        attr_accessor :title, :total_years_experience, :educations, :company_experiences

        def initialize(response)
          super(response)

          @resume = @root['Resume']
          @title = @resume['Title']
          @total_years_experience = @resume['TotalYearsExperience'].to_i rescue 0
          @educations = generate_educations(@resume['Educations']) rescue nil
          @company_experiences = generate_experiences(@resume['CompanyExperiences']) rescue nil
        end
      end
    end
  end
end
