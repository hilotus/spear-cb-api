module Spear
  module Plugins
    module Models
      include Model::User
      include Model::Resume
      include Model::Application
      include Model::Job
      include Model::TalentNetwork
    end
  end
end
