module Spear
  module Resource
    module Resume
      # file: kind of ActionDispatch::Http::UploadedFile
      def parse_file(file)
        if !file.kind_of?(ActionDispatch::Http::UploadedFile) and !file.kind_of?(Rack::Test::UploadedFile)
          raise Spear::ObjectTypeError.new("Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}")
        end

        file.rewind
        Spear::Request.new.execute(:post, "/resume/parse", {
          :body => {
            :FileName => file.original_filename,
            :FileBytes => Base64.encode64(file.read)
          }
        })
      end

      # {
      #   ShowContactInfo: true,
      #   Title: 'asasdasdasd',
      #   ResumeText: 'albee009@gmail.com JobsCentral999',
      #   Visibility: true,
      #   CanRelocateNationally: false,
      #   CanRelocateInternationally: false,
      #   TotalYearsExperience: 1,
      #   HostSite: 'T3',
      #   DesiredJobTypes: 'ETFE',
      #   CompanyExperiences: [],
      #   Educations: [],
      #   Languages: [],
      #   CustomValues: []
      # }
      def create_resume(data={})
        Spear::Request.new.execute(:post, "/resume/create", {body: data})
      end

      # {
      #   ...
      #   # if editting, we should add this column
      #   ExternalID: 'asdasdsdaas'
      # }
      def edit_resume(data={})
        Spear::Request.new.execute(:post, "/resume/edit", {body: data})
      end

      def upload_file(file, resume_external_id, user_external_id)
        if !file.kind_of?(ActionDispatch::Http::UploadedFile) and !file.kind_of?(Rack::Test::UploadedFile)
          raise Spear::ObjectTypeError.new("Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}")
        end

        raise Spear::ParametersRequired.new(%w{UserExternalId ResumeExternalId}) if user_external_id.blank? or resume_external_id.blank?

        file.rewind
        Spear::Request.new.execute(:upload_file, "/resume/upload", {
          :body => {
            :FileBytes => Base64.encode64(file.read)
          },
          :query => {
            :FileName => file.original_filename,
            :ExternalID => resume_external_id,
            :ExternalUserID => user_external_id
          }
        })
      end

      # list all of my resumes
      def own_all(user_external_id, host_site)
        raise Spear::ParametersRequired.new(%w{UserExternalId HostSite}) if user_external_id.blank? or host_site.blank?

        Spear::Request.new.execute(:get, "/resume/ownall", {
          :query => {:ExternalUserID => user_external_id, :HostSite => host_site}})
      end

      def retrieve_resume(resume_external_id, user_external_id)
        raise Spear::ParametersRequired.new(%w{UserExternalId ResumeExternalId}) if user_external_id.blank? or resume_external_id.blank?

        Spear::Request.new.execute(:get, "/resume/retrieve", {
          :query => {:ExternalUserID => user_external_id, :ExternalID => resume_external_id}})
      end
    end
  end
end
