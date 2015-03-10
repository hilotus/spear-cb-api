module Spear
  module Configuration
    @@options = {}

    def config(options={})
      set_defaults(options)

      raise Spear::ParametersRequired.new('DeveloperKey') if dev_key.nil?
      if save_api? and (!Options.instance_methods.include?(:project) or project.nil?)
        raise Spear::ParametersNotValid.new('You must specify a project name, if you want save api info.')
      end

      # add plugins to request
      include_plugins
    end

    module Options
    end

    private
      def include_plugins
        Request.include Plugins::SaveApis if save_api?
        Spear.extend(use_model? ? Plugins::Models : Resources)
      end

      def set_defaults(options)
        defaults = {
          use_test: false,
          save_api: false,
          use_model: false,
          base_uri: 'https://api.careerbuilder.com',
          time_out: 5,
          uri_application_history: '/v1/application/history',
          uri_application_create: '/cbapi/application',
          uri_application_status: '/cn/wechat/getapplicationstatus.aspx',
          uri_application_blank: '/v1/application/blank',
          uri_application_submit: '/v1/application/submit',
          uri_job_search: '/v2/jobsearch',
          uri_job_retrieve: '/v2/job',
          uri_resume_parse: '/v2/resume/parse',
          uri_resume_create: '/v2/resume/create',
          uri_resume_edit: '/v2/resume/edit',
          uri_resume_upload: '/v2/resume/upload',
          uri_resume_ownall: '/v2/resume/ownall',
          uri_resume_retrieve: '/v2/resume/retrieve',
          # job_did and format
          uri_tn_join_form_question: '/talentnetwork/config/join/questions/%s/%s',
          # format
          uri_tn_menber_create: '/talentnetwork/member/create/%s',
          uri_user_checkexisting: '/v2/user/checkexisting',
          uri_user_create: '/v2/user/create',
          uri_user_retrieve: '/v2/user/retrieve'
        }

        @@options = defaults.merge(options)
        @@options[:base_uri] = 'https://wwwtest.api.careerbuilder.com' if @@options[:use_test]

        set_option_readers
      end

      def set_option_readers
        @@options.each do |k, v|
          Options.class_eval {
            if v.kind_of?(FalseClass) or v.kind_of?(TrueClass)
              define_method(k.to_s + '?') { return v }
            else
              define_method(k) { return v }
            end
          }
        end
        # add these option method into Spear module
        Spear.extend Options
      end
  end
end
