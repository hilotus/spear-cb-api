# encoding: utf-8

module Spear
  module Resource
    module Resume
      # file: kind of ActionDispatch::Http::UploadedFile
      def parse_file(file)
        unless (file.kind_of? ActionDispatch::Http::UploadedFile) || (file.kind_of? Rack::Test::UploadedFile)
          return {"Errors" => {"Error" => "%q{Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}"}}
        end

        file.rewind
        @request.execute(:parse_file, "/resume/parse", {:FileName => file.original_filename,
          :FileBytes => Base64.encode64(file.read)})
      end

      # Required column value
      # <ShowContactInfo>true</ShowContactInfo>
      # <Title>asasdasdasd</Title>
      # <ResumeText>albee009@gmail.com JobsCentral999</ResumeText>
      # <Visibility>true</Visibility>
      # <CanRelocateNationally>false</CanRelocateNationally>
      # <CanRelocateInternationally>false</CanRelocateInternationally>
      # <TotalYearsExperience>0</TotalYearsExperience>
      # <HostSite>T3</HostSite>
      # <DesiredJobTypes>ETFE</DesiredJobTypes>
      # <CompanyExperiences/>
      # <Educations/>
      # <Languages/>
      # <CustomValues/>
      def create_resume(data={})
        @request.execute(:post, "/resume/create", data)
      end

      def upload_file(file, resume_external_id, user_external_id)
        unless (file.kind_of? ActionDispatch::Http::UploadedFile) || (file.kind_of? Rack::Test::UploadedFile)
          return {"Errors" => {"Error" => "%q{Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}"}}
        end

        if user_external_id.blank? or resume_external_id.blank?
          return {"Errors" => {"Error" => "%q{User external ID and resume external ID is required.}"}}
        end

        file.rewind
        @request.execute(:upload_file, "/resume/upload", {
          :body => Base64.encode64(file.read),
          :query => {
            :FileName => file.original_filename,
            :ExternalID => resume_external_id,
            :ExternalUserID => user_external_id
          }
        })
      end

      # list all of my resumes
      def own_all(user_external_id, host_site)
        if user_external_id.blank? or host_site.blank?
          return {"Errors" => {"Error" => "%q{User external ID and host site is required.}"}}
        end

        @request.execute(:get, "/resume/ownall", {
          :query => {:ExternalUserID => user_external_id, :HostSite => host_site}})
      end

      def retrieve_resume(resume_external_id, user_external_id)
        if user_external_id.blank? or resume_external_id.blank?
          return {"Errors" => {"Error" => "%q{User external ID and host site is required.}"}}
        end

        @request.execute(:get, "/resume/retrieve", {
          :query => {:ExternalUserID => user_external_id, :ExternalID => resume_external_id}})
      end
    end
  end
end
