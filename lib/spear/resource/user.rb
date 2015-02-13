# encoding: utf-8

module Spear
  module Resource
    module User
      def check_existing(email, password='')
        if password.blank?
          @request.execute(:post, "/user/checkexisting", {:Email => email})
        else
          @request.execute(:post, "/user/checkexisting", {:Email => email, :Password => password})
        end
      end

      def create_user(data={})
        @request.execute(:post, "/user/create", data)
      end

      def retrieve_user(user_external_id, password)
        @request.execute(:post, "/user/retrieve", {:ExternalID => user_external_id, :Password => password})
      end
    end
  end
end
