module Spear
  module Resource
    module TalentNetwork
      def join_form_questions(talent_network_did)
        raise Spear::ParametersRequired.new('TalentNetworkDID') if talent_network_did.blank?

        Spear::Request.new(:get, Spear.uri_tn_join_form_question % [talent_network_did, 'json'], {
          api_options: {need_test_element: true}}).execute
      end

      def create_member(data={})
        Spear::Request.new(:post, Spear.uri_tn_menber_create % ['json'], {
          api_options: {need_test_element: true}, body: data}).execute
      end
    end
  end
end
