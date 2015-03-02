module Spear
  module Resource
    module User
      def check_existing(email, password='')
        if password.blank?
          Spear::Request.new.execute(:post, "/user/checkexisting", {body: {:Email => email}})
        else
          Spear::Request.new.execute(:post, "/user/checkexisting", {body: {:Email => email, :Password => password}})
        end
      end

      # {
      #   FirstName: 'asdasdad',
      #   LastName: 'asdasdad',
      #   Email: 'ascacasc@sina.com.cn',
      #   Password: 'Qwer1234!',
      #   Phone: '+657777888999',
      #   City: 'Singapore',
      #   State: 'SG',
      #   CountryCode: 'SG',
      #   AllowNewsletterEmails: false,
      #   HostSite: 'T3',
      #   AllowPartnerEmails: false,
      #   AllowEventEmails: false,
      #   SendEmail: false,
      #   Gender: 'U',
      #   UserType: 'jobseeker',
      #   Status: 'active',
      #   Test: false
      # }
      def create_user(data={})
        Spear::Request.new.execute(:post, "/user/create", {body: data})
      end

      def retrieve_user(user_external_id, password)
        Spear::Request.new.execute(:post, "/user/retrieve", {body: {:ExternalID => user_external_id, :Password => password}})
      end
    end
  end
end
