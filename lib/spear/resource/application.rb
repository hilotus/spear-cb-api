module Spear
  module Resource
    module Application
      def history(user_external_id)
        raise Spear::ParametersRequired.new('UserExternalId') if user_external_id.blank?

        Spear::Request.new(:get, "/application/history",
          {query: {:ExternalID => user_external_id}, api_options: {path: '/v1'}}).execute
      end

      # Application Creation
      def create_application(host_site, data={})
        raise Spear::ParametersRequired.new('HostSite') if host_site.blank?
        raise Spear::ParametersRequired.new(%w{JobID Resume Responses}) if data[:JobDID].blank? or data[:Resume].nil? or data[:Responses].nil?

        Spear::Request.new(:apply, '',
          {query: {:HostSite => host_site}, body: data, api_options: {path: "/cbapi/application"}}).execute
      end
    end
  end
end
