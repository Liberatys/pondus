# frozen_string_literal: true

require_relative "pondus/version"
require_relative "pondus/base"
require_relative "pondus/configuration"
require_relative "pondus/attribute"
require_relative "pondus/matcher"
require_relative "pondus/strategies/string_matcher"
require_relative "pondus/strategies/boolean_matcher"

module Pondus
  class Error < StandardError; end

  def self.extended(model_class)
    return if model_class.respond_to?(:scored)

    model_class.class_eval do
      extend Base
      attr_accessor :pondus_score
      @pondus_scored_config = Class.new(Configuration).new(self)
      include Model
    end
  end

  def self.included(model_class)
    model_class.extend self
  end
end
