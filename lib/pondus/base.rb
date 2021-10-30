module Pondus
  MAX_SCORE = 100
  MIN_SCORE = 0

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
      models_for_scoring = all
      return @pondus_scored_config.model_class.none if models_for_scoring.empty?

      if @pondus_scored_config.scored_attributes && @pondus_scored_config.scored_attributes.empty?
        models_for_scoring
      else
        Matcher.new(
          models_for_scoring,
          @pondus_scored_config.scored_attributes,
          sort_params
        ).sort
      end
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
