module Gisele
  module Language
    class ScopingHelper < Sexpr::Processor::Helper

      module Methods

        def scope_stack
          @scope_stack ||= []
        end

        def with_scope(scope)
          scope_stack.push(scope)
          result = yield
          scope_stack.pop
          result
        end

      end # module Methods

      def on_missing(rw, sexpr)
        if sexpr.first.to_s =~ /_def/
          rw.with_scope(sexpr) do
            yield(rw, sexpr)
          end
        else
          yield(rw, sexpr)
        end
      end

    end # module ScopingHelper
  end # module Language
end # module Gisele