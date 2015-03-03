module Spear
  module Structure
    module Job
      module EmbededClass
        ##################################################################
        # Resume embeded class
        ##################################################################
        class CbJob
          attr_accessor :did, :tn_did, :job_title, :state, :city, :posted_date, :employment_type

          def initialize(tn_did, job={})
            @did = job['DID']
            @tn_did = tn_did
            @job_title = job['JobTitle']
            @state = job['State']
            @city = job['City']
            @posted_date = Date.strptime(job['PostedDate'], '%m/%d/%Y').to_time.strftime('%Y-%m-%d')
            @employment_type = job['EmploymentType']
          end
        end

        def generate_jobs(jobs, tn_did)
          if !jobs.nil?
            if jobs.kind_of?(Array)
              jobs.map {|job| CbJob.new(tn_did, job)}
            else  # Hash
              [CbJob.new(tn_did, jobs)]
            end
          else
            []
          end
        end

      end
    end
  end
end
