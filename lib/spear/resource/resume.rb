module Spear
  module Resource
    module Resume
      # file: kind of ActionDispatch::Http::UploadedFile
      def parse_file(file)
        if !file.kind_of?(ActionDispatch::Http::UploadedFile) and !file.kind_of?(Rack::Test::UploadedFile)
          raise Spear::ObjectTypeError.new("Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}")
        end

        file.rewind
        Spear::Request.new(:post, "/resume/parse", {
          :body => {
            :FileName => file.original_filename,
            :FileBytes => Base64.encode64(file.read)
          }
        }).execute
      end

      def create_resume(data={})
        Spear::Request.new(:post, "/resume/create", {body: data}).execute
      end

      def edit_resume(data={})
        raise Spear::ParametersRequired.new('Resume ExternalId') if data[:ExternalID].blank?

        Spear::Request.new(:post, "/resume/edit", {body: data}).execute
      end

      def upload_file(file, resume_external_id, user_external_id)
        if !file.kind_of?(ActionDispatch::Http::UploadedFile) and !file.kind_of?(Rack::Test::UploadedFile)
          raise Spear::ObjectTypeError.new("Expecting type of ActionDispatch::Http::UploadedFile or Rack::Test::UploadedFile, but got #{file.class}.}")
        end

        raise Spear::ParametersRequired.new(%w{UserExternalId ResumeExternalId}) if user_external_id.blank? or resume_external_id.blank?

        file.rewind
        Spear::Request.new(:upload_file, "/resume/upload", {
          :body => {
            :FileBytes => Base64.encode64(file.read)
          },
          :query => {
            :FileName => file.original_filename,
            :ExternalID => resume_external_id,
            :ExternalUserID => user_external_id
          }
        }).execute
      end

      # list all of my resumes
      def own_all(user_external_id, host_site)
        raise Spear::ParametersRequired.new(%w{UserExternalId HostSite}) if user_external_id.blank? or host_site.blank?

        Spear::Request.new(:get, "/resume/ownall", {
          :query => {:ExternalUserID => user_external_id, :HostSite => host_site}}).execute
      end

      def retrieve_resume(resume_external_id, user_external_id)
        raise Spear::ParametersRequired.new(%w{UserExternalId ResumeExternalId}) if user_external_id.blank? or resume_external_id.blank?

        Spear::Request.new(:get, "/resume/retrieve", {
          :query => {:ExternalUserID => user_external_id, :ExternalID => resume_external_id}}).execute
      end
    end
  end
end
