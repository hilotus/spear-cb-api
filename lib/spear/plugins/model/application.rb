module Spear
  module Plugins
    module Model
      module Application
        include Resource::Application

        def history(user_external_id)
          response = super(user_external_id)
          Structure::Application::History.new(response)
        end

        # Application Creation
        def create_application(host_site, data={})
          response = super(host_site, data)
          Structure::Application::Create.new(response)
        end

        def application_status(app_dids=[])
          response = super(app_dids)
          Structure::Application::State.new(response)
        end

        def application_blank(job_did)
          response = super(job_did)
          Structure::Application::Blank.new(response)
        end

        def application_submit(job_did, questions=[])
          response = super(job_did, questions)
          Structure::Application::Submit.new(response)
        end
      end
    end
  end
end
