module Spear
  module Configuration
    include Resources

    @@options = {}

    def test?
      @@options[:use_test] || false
    end

    # use https or http
    def ssh?
      @@options[:use_ssh] || true
    end

    def hostname
      @@options[:hostname] || 'api.careerbuilder.com'
    end

    def port
      @@options[:port] || 443
    end

    def version
      @@options[:version] || "v2"
    end

    def dev_key
      @@options[:dev_key]
    end

    # need save api info
    def save_api?
      @@options[:saving_api] || false
    end

    def use_model?
      @@options[:using_model] || false
    end

    def project
      @@options[:project]
    end

    def config(options)
      @@options = options

      raise Spear::ParametersRequired.new('DeveloperKey') if dev_key.nil?
      raise Spear::ParametersNotValid.new('You must specify a project name, if you want save api info.') if save_api? and project.nil?

      # add plugins to request
      include_plugins
    end

    private
      def include_plugins
        Request.include Plugins::SaveApis if save_api?
        Spear.extend Plugins::Models if use_model?
      end

  end
end
