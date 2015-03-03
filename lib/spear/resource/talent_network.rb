module Spear
  module Resource
    module TalentNetwork
      def join_form_questions(talent_network_did)
        raise Spear::ParametersRequired.new('TalentNetworkDID') if talent_network_did.blank?

        Spear::Request.new(:get, '',
          {api_options: {path: "/talentnetwork/config/join/questions/#{talent_network_did}/json"}}).execute
      end

      def create_member(data={})
        Spear::Request.new(:post, '', {api_options:
          {path: "/talentnetwork/member/create/json", :need_test_key => false}, body: data}).execute
      end
    end
  end
end
