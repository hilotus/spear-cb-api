module Spear
  module Plugins
    module Model
      module Job
        def search_job(params={})
          response = super(params)
          Structure::Job::Search.new(response)
        end

        def retrieve_job(job_id, host_site)
          response = super(job_id, host_site)
          Structure::Job::Retrieve.new(response)
        end
      end
    end
  end
end
