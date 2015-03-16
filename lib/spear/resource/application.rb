module Spear
  module Resource
    module Application
      def history(user_external_id)
        raise Spear::ParametersRequired.new('UserExternalId') if user_external_id.blank?

        Spear::Request.new(:get, Spear.uri_application_history, {
          query: {:ExternalID => user_external_id}}).execute
      end

      # Application Creation
      def create_application(host_site, data={})
        raise Spear::ParametersRequired.new('HostSite') if host_site.blank?

        if data[:JobDID].blank? or data[:Resume].nil? or data[:Responses].nil?
          raise Spear::ParametersRequired.new(%w{JobID Resume Responses})
        end

        Spear::Request.new(:apply, Spear.uri_application_create, {
          header: {:HostSite => host_site}, body: data}).execute
      end

      # ids: application_did array, or job_did
      def application_status(ids, email=nil)
        if ids.kind_of?(String) and !email.blank?
          Spear::Request.new(:get, Spear.uri_application_status, {query: {JobDID: ids, Email: email}}).execute
        elsif ids.kind_of?(Array)
          Spear::Request.new(:get, Spear.uri_application_status, {query: {AppDID: ids.join(',')}}).execute
        else
          raise Spear::ParametersNotValid.new
        end
      end

      def application_blank(job_did)
        raise Spear::ParametersRequired.new('JobDID') if job_did.blank?
        Spear::Request.new(:get, Spear.uri_application_blank, {query: {JobDID: job_did}}).execute
      end

      def application_submit(job_did, questions=[])
        raise Spear::ParametersRequired.new('JobDID') if job_did.blank?
        Spear::Request.new(:post, Spear.uri_application_submit, {
          api_options: {root_element: 'RequestApplication'}, body: {JobDID: job_did, Responses: questions}}).execute
      end
    end
  end
end
