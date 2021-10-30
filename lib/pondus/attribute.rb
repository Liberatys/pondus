module Pondus
  class Attribute
    attr_accessor :weight
    attr_accessor :weight_strategy
    attr_reader :column
    attr_reader :strategy
    attr_reader :expected_value
    attr_reader :param_key

    def initialize(column: nil, strategy: nil, weight: nil, weight_strategy: :auto, param_key: nil, expected_value: true)
      @column = column
      @strategy = strategy
      @weight = weight
      @param_key = param_key || column.to_sym
      @expected_value = expected_value
      @weight_strategy = weight.present? ? :fixed : weight_strategy
    end
  end
end
