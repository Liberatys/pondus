module Pondus
  class Matcher
    MAX_WEIGHT = 100
    BASE_SCORE = 0

    def initialize(models, scored_by, sort_params)
      @models = models
      @scored_by = scored_by
      @sort_params = sort_params
    end

    def sort
      score

      @models.sort { |a, b| b.pondus_score <=> a.pondus_score }
    end

    def score
      @models.each do |model|
        model.pondus_score = calculate_score(model)
      end
    end

    private

    def calculate_score(model_instance)
      @scored_by.reduce(BASE_SCORE) do |sum, scored_by|
        plain_scored = unweighted_score(scored_by, model_instance)

        sum + (plain_scored * (scored_by.weight / MAX_WEIGHT))
      end
    end

    def unweighted_score(attribute, model_instance)
      case attribute.strategy
      when :string_match
        Strategies::StringMatcher.score(model_instance.send(attribute.column), @sort_params[attribute.param_key])
      else
        Strategies::StringMatcher.score(model_instance.send(attribute.column), @sort_params[attribute.param_key])
      end
    end
  end
end
