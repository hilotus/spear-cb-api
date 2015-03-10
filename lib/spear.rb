# encoding: utf-8

require 'active_support'
require 'active_support/core_ext'

require 'sucker_punch'
require 'httparty'

module Spear
  autoload :Configuration, 'spear/configuration'
  autoload :Resources, 'spear/resources'
  autoload :Request, 'spear/request'

  autoload :ParametersRequired, 'spear/exceptions'
  autoload :ParametersNotValid, 'spear/exceptions'
  autoload :NetworkError, 'spear/exceptions'
  autoload :ObjectTypeError, 'spear/exceptions'

  module Structure
    autoload :Base, 'spear/structure/base'

    module User
      autoload :CheckExisting, 'spear/structure/user/check_existing'
      autoload :Create, 'spear/structure/user/create'
      autoload :Retrieve, 'spear/structure/user/retrieve'
    end

    module Resume
      autoload :EmbededClass, 'spear/structure/resume/embeded_class'
      autoload :Create, 'spear/structure/resume/create'
      autoload :Edit, 'spear/structure/resume/edit'
      autoload :Ownall, 'spear/structure/resume/ownall'
      autoload :Parse, 'spear/structure/resume/parse'
      autoload :Retrieve, 'spear/structure/resume/retrieve'
      autoload :Upload, 'spear/structure/resume/upload'
    end

    module Application
      autoload :Create, 'spear/structure/application/create'
      autoload :History, 'spear/structure/application/history'
      autoload :State, 'spear/structure/application/state'
      autoload :Blank, 'spear/structure/application/blank'
      autoload :Submit, 'spear/structure/application/submit'
    end

    module Job
      autoload :EmbededClass, 'spear/structure/job/embeded_class'
      autoload :Search, 'spear/structure/job/search'
      autoload :Retrieve, 'spear/structure/job/retrieve'
    end

    module TalentNetwork
      autoload :EmbededClass, 'spear/structure/talent_network/embeded_class'
      autoload :CreateMember, 'spear/structure/talent_network/create_member'
      autoload :JoinFormQuestion, 'spear/structure/talent_network/join_form_question'
    end
  end

  module Plugins
    autoload :SaveApis, 'spear/plugins/save_apis'
    autoload :Models, 'spear/plugins/models'

    module Model
      autoload :User, 'spear/plugins/model/user'
      autoload :Resume, 'spear/plugins/model/resume'
      autoload :Application, 'spear/plugins/model/application'
      autoload :Job, 'spear/plugins/model/job'
      autoload :TalentNetwork, 'spear/plugins/model/talent_network'
    end
  end

  module Resource
    autoload :User, 'spear/resource/user'
    autoload :Resume, 'spear/resource/resume'
    autoload :Application, 'spear/resource/application'
    autoload :Job, 'spear/resource/job'
    autoload :TalentNetwork, 'spear/resource/talent_network'
  end

  extend Configuration
end
