# encoding: utf-8

module Spear
  module Resource
    module Application
      def history(user_external_id)
        raise Spear::ParametersRequired.new('UserExternalId') if user_external_id.blank?

        Spear::Request.new.execute(:get, "/application/history",
          {query: {:ExternalID => user_external_id}, api_options: {path: 'v1'}})
      end

      # Application Creation
      def create_application(host_site, data={})
        raise Spear::ParametersRequired.new('HostSite') if host_site.blank?

        Spear::Request.new.execute(:apply, "/cbapi/application",
          {query: {:HostSite => host_site}, body: data, api_options: {path: ""}})
      end
    end
  end
end
