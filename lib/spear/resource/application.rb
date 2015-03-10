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

      def application_status(app_dids=[])
        Spear::Request.new(:get, Spear.uri_application_status, {
          query: {sApplDID: app_dids.join(',')}}).execute
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
