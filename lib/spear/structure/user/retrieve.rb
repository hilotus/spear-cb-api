module Spear
  module Structure
    module User
      class Retrieve < Structure::Base
        attr_reader :external_id
        attr_accessor :email, :first_name, :last_name, :phone

        def initialize(response)
          super(response)

          @user_info = @root['UserInfo']
          @external_id = @root['Request']['ExternalID']
          @email = @user_info['Email']
          @first_name = @user_info['FirstName']
          @last_name = @user_info['LastName']
          @phone = @user_info['Phone']
        end
      end
    end
  end
end
