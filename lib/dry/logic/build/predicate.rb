# frozen_string_literal: true

module Dry
  module Logic
    module Build
      class Predicate < Base
        def method_missing(method, *args, **kwargs, &block)
          super unless respond_to_missing?(method)
          super if Kernel.block_given?
          super unless kwargs.empty?

          to_predicate(method).curry(*args)
        end

        def respond_to_missing?(method, *)
          Predicates.methods.include?(method)
        end

        private

        def to_predicate(name)
          (@predicate ||= {})[name] ||= Rule::Predicate.new(Predicates[name])
        end
      end
    end
  end
end
