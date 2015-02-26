module Spear
  class Error < StandardError; end

  class ParametersRequired < Error
    attr_reader :parameter

    def initialize(parameter)
      if parameter.kind_of?(Array)
        @parameter = parameter.join(', ')
      else
        @parameter = parameter
      end

      super("#{@parameter} is required.")
    end
  end

  class ParametersNotValid < Error; end
  class NetworkError < Error; end
  class ObjectTypeError < Error; end
end
