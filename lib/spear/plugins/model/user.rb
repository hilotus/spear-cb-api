module Spear
  module Plugins
    module Model
      module User
        include Resource::User

        def check_existing(email, password='')
          response = super(email, password)
          Structure::User::CheckExisting.new(response)
        end

        def create_user(data={})
          response = super(data)
          Structure::User::Create.new(response)
        end

        def retrieve_user(user_external_id, password)
          response = super(user_external_id, password)
          Structure::User::Retrieve.new(response)
        end

        def token_authenticate(user_external_id)
          response = super(user_external_id)
          Structure::User::TokenAuthenticate.new(response)
        end

      end
    end
  end
end
