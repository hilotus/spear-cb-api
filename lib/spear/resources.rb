# encoding: utf-8

module Spear
  module Resources
    include Resource::User
    include Resource::Resume
    include Resource::Application
    include Resource::Job
  end
end