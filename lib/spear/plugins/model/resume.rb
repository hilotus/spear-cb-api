module Spear
  module Plugins
    module Model
      module Resume
        def parse_file(file)
          response = super(file)
          response = Structure::Resume::Parse.new(response)
        end

        def create_resume(data={})
          response = super(data)
          response = Structure::Resume::Create.new(response)
        end

        def edit_resume(data={})
          response = super(data)
          response = Structure::Resume::Edit.new(response)
        end

        def upload_file(file, resume_external_id, user_external_id)
          response = super(file, resume_external_id, user_external_id)
          response = Structure::Resume::Upload.new(response)
        end

        def own_all(user_external_id, host_site)
          response = super(user_external_id, host_site)
          response = Structure::Resume::Ownall.new(response)
        end

        def retrieve_resume(resume_external_id, user_external_id)
          response = super(user_external_id, host_site)
          response = Structure::Resume::Retrieve.new(response)
        end

      end
    end
  end
end
