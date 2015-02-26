# encoding: utf-8

module Spear
  module Resource
    module TalentNetwork
      def join_form_questions(talent_network_did)
        raise Spear::ParametersRequired.new('TalentNetworkDID') if talent_network_did.blank?

        Spear::Request.new.execute(:get, "/talentnetwork/config/join/questions/#{talent_network_did}/json",
          {api_options: {path: ""}})
      end

      # {
      #   TalentNetworkDID: 'YourTalentNetworkDID',
      #   PreferredLanguage: 'USEnglish',
      #   AcceptPrivacy: '',
      #   AcceptTerms: '',
      #   ResumeWordDoc: '',
      #   JoinValues: [
      #     {Key: 'MxDOTalentNetworkMemberInfo_EmailAddress', Value: 'some.email@example.com'},
      #     {Key: 'JQ7I3CM6P9B09VCVD9YF', Value: 'AVAILABLENOW'}
      #   ]
      # }
      def create_member(data={})
        Spear::Request.new.execute(:post, "/talentnetwork/member/create/json",
          {api_options: {path: ""}, body: data})
      end
    end
  end
end
