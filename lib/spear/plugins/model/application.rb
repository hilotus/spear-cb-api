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
      end
    end
  end
end
