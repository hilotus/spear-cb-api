# encoding: utf-8

module Spear
  module Resource
    module Job
      def search_job(params={})
        Spear::Request.new.execute(:get, "/jobsearch", {:query => params})
      end

      # job_id:
      #   20 character long unique job ID.
      #   It's one of the elements received in every v1/jobsearch result item.
      def retrieve_job(job_id, host_site)
        raise Spear::ParametersRequired.new(%w{JobID HostSite}) if job_id.blank? or host_site.blank?

        Spear::Request.new.execute(:get, "/job", {:query => {:DID => job_id, :HostSite => host_site}})
      end
    end
  end
end
