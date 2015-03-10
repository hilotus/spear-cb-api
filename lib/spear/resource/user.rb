module Spear
  module Resource
    module User
      def check_existing(email, password='')
        if password.blank?
          Spear::Request.new(:post, Spear.uri_user_checkexisting, {body: {:Email => email}}).execute
        else
          Spear::Request.new(:post, Spear.uri_user_checkexisting, {
            body: {:Email => email, :Password => password}}).execute
        end
      end

      def create_user(data={})
        Spear::Request.new(:post, Spear.uri_user_create, {body: data}).execute
      end

      def retrieve_user(user_external_id, password)
        Spear::Request.new(:post, Spear.uri_user_retrieve, {
          body: {:ExternalID => user_external_id, :Password => password}}).execute
      end
    end
  end
end
