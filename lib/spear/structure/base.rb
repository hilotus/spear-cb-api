module Spear
  module Structure
    class Base
      # response is an instance of Httparty::Response
      attr_reader :response, :root, :status, :error_message

      def initialize(response)
        raise Spear::ParametersRequired.new('Response') if response.nil?

        @response = response

        # Note: <b>Application Form API</b> return html string.

        if response.kind_of?(Hash)
          # get the root keyvalue of the hash
          if response.to_h.has_key?('Errors')
            @root = response.to_h
          else
            @root = response.to_h.first.last
          end

          # Note: <b>Application Status API</b> is different.
          @status = @root["Status"] || @root['ApplicationStatus']
          @error_message = get_error_message(@root)
        end
      end

      def success?
        @status.nil? ? @error_message.nil? : (@status.include?('Success') or @status.include?('Complete'))
      end

      private
        def get_error_message(hash)
          if hash["Errors"].kind_of?(Hash)
            if !hash["Errors"]["Error"].kind_of?(Hash)
              # 1. Api error response is an array
              if hash["Errors"]["Error"].kind_of?(Array)
                return hash["Errors"]["Error"].join(", ")
              end
              # 2. Api error response is a string
              return hash["Errors"]["Error"]
            else
              # 3. Api error response is a hash
              if !hash["Errors"]["Error"]["Message"].nil?
                return hash["Errors"]["Error"]["Message"]
              end
            end
          elsif hash["Errors"].kind_of?(Array)
            return hash["Errors"].first
          elsif hash["Errors"].kind_of?(String)
            return hash["Errors"]
          end
        end
    end
  end
end
