module Spear
  module Resource
    module User
      def check_existing(email, password='')
        if password.blank?
          Spear::Request.new(:post, "/user/checkexisting", {body: {:Email => email}}).execute
        else
          Spear::Request.new(:post, "/user/checkexisting", {body: {:Email => email, :Password => password}}).execute
        end
      end

      def create_user(data={})
        Spear::Request.new(:post, "/user/create", {body: data}).execute
      end

      def retrieve_user(user_external_id, password)
        Spear::Request.new(:post, "/user/retrieve", {body: {:ExternalID => user_external_id, :Password => password}}).execute
      end
    end
  end
end
