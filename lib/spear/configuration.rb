module Spear
  module Configuration
    @@options = {}

    # use https or http
    def ssh?
      @@options[:use_ssh].nil? ? true : @@options[:use_ssh]
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

    def test?
      @@options[:use_test].nil? ? false : @@options[:use_test]
    end

    def dev_key
      @@options[:dev_key]
    end

    # need save api info
    def save_api?
      @@options[:saving_api].nil? ? false : @@options[:saving_api]
    end

    def use_model?
      @@options[:using_model].nil? ? false : @@options[:using_model]
    end

    def project
      @@options[:project]
    end

    # def use_dummy?
    #   @@options[:using_dummy] || false
    # end

    def config(options={})
      @@options = options.merge!({use_ssh: true, hostname: 'api.careerbuilder.com', port: 443, version: 'v2'})

      raise Spear::ParametersRequired.new('DeveloperKey') if dev_key.nil?
      raise Spear::ParametersNotValid.new('You must specify a project name, if you want save api info.') if save_api? and project.nil?

      # add plugins to request
      include_plugins
    end

    private
      def include_plugins
        Request.include Plugins::SaveApis if save_api?

        if use_model?
          Spear.extend Plugins::Models
        else
          Spear.extend Resources
        end

        # Spear.extend Dummy if use_dummy?
      end

  end
end
