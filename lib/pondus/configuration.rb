module Pondus
  class Configuration
    MAX_WEIGHT_SUM = 100
    AUTO_WEIGHT_STRATEGY = :auto

    attr_accessor :model_class
    attr_reader :defaults
    attr_writer :base
    attr_reader :scored_attributes

    def initialize(model_class)
      @base = nil
      @model_class = model_class
      @scored_attributes = []
    end

    def score_attribute(attribute)
      @scored_attributes << attribute
      balance_attribute_weights # TBD
      p @scored_attributes
    end

    # TODO: Refactor && Test
    def balance_attribute_weights
      attribute_count = @scored_attributes.count
      reserved_weight = @scored_attributes.sum { |attr| attr.weight_strategy == AUTO_WEIGHT_STRATEGY ? 0 : attr.weight }

      distributable_weight = MAX_WEIGHT_SUM - reserved_weight
      # TODO: Fix issue when division results in floats
      per_attribute_weight = distributable_weight / attribute_count

      @scored_attributes.each do |scored_attribute|
        scored_attribute.weight = per_attribute_weight if scored_attribute.weight_strategy == AUTO_WEIGHT_STRATEGY
      end
    end
  end
end
