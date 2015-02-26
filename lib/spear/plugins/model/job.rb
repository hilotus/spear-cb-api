module Spear
  module Plugins
    module Model
      module Job
        def search_job(params={})
          response = super(params)
          Structure::Job::Search.new(response)
        end
      end
    end
  end
end
