module Pondus
  module Base
    def scored_by(attribute, options = {})
      pondus_scored_config.score_attribute(
        Class.new(Attribute).new(
          column: attribute,
          **options
        )
      )
    end

    def scored(sort_params = {})
      Class.new(Matcher).new(
        all,
        @pondus_scored_config.scored_attributes,
        sort_params
      ).sort
    end

    def pondus_scored_config
      @pondus_scored_config ||= base_class.pondus_scored_config.dup.tap do |config|
        config.model_class = self
      end
    end
  end

  module Model
    def self.included(model_class)
      return if model_class.respond_to?(:scored)
    end
  end
end
