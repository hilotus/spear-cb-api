# encoding: utf-8

require "spear/version"

module Spear
  autoload :AsyncJob, 'spear/async_job'
  autoload :Client, 'spear/client'
  autoload :Request, 'spear/request'

  module Resource
    autoload :User, 'spear/resource/user'
    autoload :Resume, 'spear/resource/resume'
  end
end
