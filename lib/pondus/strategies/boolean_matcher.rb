module Pondus
  module Strategies
    class BooleanMatcher
      class << self
        def score(column_value, expected_value)
          ActiveModel::Type::Boolean.new.cast(column_value) == expected_value ? MAX_SCORE : MIN_SCORE
        end
      end
    end
  end
end
