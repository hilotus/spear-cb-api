module Spear
  module Plugins
    module Model
      module TalentNetwork
        include Resource::TalentNetwork

        def join_form_questions(talent_network_did)
          response = super(talent_network_did)
          Structure::TalentNetwork::JoinFormQuestion.new(response)
        end

        def create_member(data={})
          response = super(data)
          Structure::TalentNetwork::CreateMember.new(response)
        end
      end
    end
  end
end
