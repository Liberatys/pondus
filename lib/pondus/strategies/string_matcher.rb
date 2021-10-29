module Pondus
  module Strategies
    class StringMatcher
      MAX_SCORE = 100
      MIN_SCORE = 0
      class << self
        # TODO: Implement
        def score(partial, complete)
          p partial
          p complete
          return MAX_SCORE if partial.blank?
          return MIN_SCORE if complete.blank?

          target_fractions(partial, complete)
        end

        def target_fractions(partial, target)
          target_arr = target.downcase.scan(/[a-z]/)
          target_size = target_arr.size
          s_arr = partial.downcase.scan(/[a-z]/)
          target_remaining = array_difference(target_arr, s_arr)
          ((target_size - target_remaining.size) / target_size.to_f) * 100
        end

        def array_difference(first, second)
          h = second.each_with_object(Hash.new(0)) { |e, h| h[e] += 1 }
          first.reject { |e| h[e] > 0 && h[e] -= 1 }
        end
      end
    end
  end
end
