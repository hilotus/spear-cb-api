module Spear
  module Resource
    module Job
      def search_job(params={})
        Spear::Request.new.execute(:get, "/jobsearch", {:query => params})
      end

      # job_id:
      #   20 character long unique job ID.
      #   It's one of the elements received in every v1/jobsearch result item.
      def retrieve_job(job_id)
        raise Spear::ParametersRequired.new('JobID') if job_id.blank?

        Spear::Request.new.execute(:get, "/job", {:query => {:DID => job_id}})
      end
    end
  end
end
