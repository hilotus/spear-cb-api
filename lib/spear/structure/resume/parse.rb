module Spear
  module Structure
    module Resume
      # after parse resume, we will call create resume api. So in this class, we will build
      # the data class structure 'Create resume' needs.
      class Parse < Structure::Base
        include EmbededClass

        attr_reader :resume, :hrxml_resume
        attr_accessor :educations, :company_experiences, :employer_orgs, :languages, :custom_values
        attr_accessor :resume_text, :total_years_experience

        def initialize(response)
          super(response)

          @resume = @root['Resume'] || {}
          @hrxml_resume = @resume['HRXMLResume']

          @resume_text = @resume['ResumeText'] || ''
          @total_years_experience = @resume['TotalYearsExperience'].to_i rescue 0
          @educations = generate_educations(@resume['Educations']) rescue nil
          @company_experiences = generate_experiences(@resume['CompanyExperiences']) rescue nil
        end

        def hash_for_create(external_user_id, host_site)
          raise Spear::ParametersRequired.new(%w{UserExternalId HostSite}) if external_user_id.blank? or host_site.blank?

          # Max Educations are 3
          educations = []
          @educations.each_with_index do |e, index|
            break if index > 2
            edu = {}
            edu[:SchoolName] = e.school_name || ""
            edu[:Major] = e.major || ""
            edu[:DegreeCode] = e.degree_code || ""
            edu[:GraduationDate] = e.graduation_date unless e.graduation_date.blank?
            educations << edu
          end

          # Max CompanyExperiences are 5
          company_experiences = []
          @company_experiences.each_with_index do |ce, index|
            break if index > 4
            cen = {}
            cen[:CompanyName] = ce.company_name || ""
            cen[:JobTitle] = ce.job_title || ""
            if ce.start_date.blank?
              cen[:StartDate] = '1970-01-01'
            else
              cen[:StartDate] = ce.start_date
            end
            if ce.end_date.blank?
              cen[:EndDate] = Time.now.strftime("%Y-%m-%d").to_s
            else
              cen[:EndDate] = ce.end_date
            end
            cen[:Details] = ce.details || ""
            company_experiences << cen
          end

          {
            :ExternalUserID => external_user_id,
            :ShowContactInfo => true,
            :Title => 'title',
            :ResumeText => @resume_text,
            :Visibility => 'Public',
            :CanRelocateNationally => false,
            :CanRelocateInternationally => false,
            :TotalYearsExperience => @total_years_experience.to_s,
            :HostSite => host_site,
            :DesiredJobTypes => 'ETFE',
            :CompanyExperiences => company_experiences,
            :Educations => educations,
            :Languages => [],
            :CustomValues => []
          }
        end
      end
    end
  end
end
