# TODO: Extract Languages and EmployerOrgs ...
module Spear
  module Structure
    module Resume
      module EmbededClass
        ##################################################################
        # Resume embeded class
        ##################################################################
        class Education
          attr_accessor :school_name, :major, :degree_name, :degree_code, :degree_type, :graduation_date

          def initialize(education={})
            @school_name = education['SchoolName']
            @major = education['Major']
            @degree_name = education['DegreeName']
            @degree_code = education['DegreeCode']
            @degree_type = education['DegreeType']
            @graduation_date = education['GraduationDate']
          end
        end

        def generate_educations(educations)
          if !educations.nil?
            if educations['Education'].kind_of?(Array)
              educations['Education'].map {|e| Education.new(e)}
            else  # Hash
              [Education.new(educations['Education'])]
            end
          else
            []
          end
        end

        class CompanyExperience
          # Date must more than 1970-01-01
          attr_accessor :company_name, :job_title, :start_date, :end_date, :details, :is_current

          def initialize(experience={})
            @company_name = experience['CompanyName']
            @job_title = experience['JobTitle']
            @start_date = experience['StartDate']
            @end_date = experience['EndDate']
            @details = experience['Details']
            @is_current = %w(True ture).include?(experience['IsCurrent'])
          end
        end

        def generate_experiences(company_experiences)
          if !company_experiences.nil?
            if company_experiences['CompanyExperience'].kind_of?(Array)
              company_experiences['CompanyExperience'].map {|e| CompanyExperience.new(e)}
            else  # Hash
              [CompanyExperience.new(company_experiences['CompanyExperience'])]
            end
          else
            []
          end
        end
      end
    end
  end
end
