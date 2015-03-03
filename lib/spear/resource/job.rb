module Spear
  module Resource
    module Job
      def search_job(params={})
        Spear::Request.new(:get, "/jobsearch", {:query => params}).execute
      end

      # job_id:
      #   20 character long unique job ID.
      #   It's one of the elements received in every v1/jobsearch result item.
      def retrieve_job(job_id)
        raise Spear::ParametersRequired.new('JobID') if job_id.blank?

        Spear::Request.new(:get, "/job", {:query => {:DID => job_id}}).execute
      end
    end
  end
end
