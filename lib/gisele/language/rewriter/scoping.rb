module Gisele
  module Language
    class Rewriter
      class Scoping < Helper

        module Methods

          def scoping_helper
            @scoping_helper ||= Scoping.new
          end

          def scope_stack
            @scope_stack ||= []
          end

          def with_scope(scope)
            scope_stack.push(scope)
            yield
            scope_stack.pop
          end

        end # module Methods

        def on_missing(rw, node)
          if node.rule_name.to_s =~ /_def/
            rw.with_scope(node) do
              yield(rw, node)
            end
          else
            yield(rw, node)
          end
        end

      end # module Scoping
    end # class Rewriter
  end # module Language
end # module Gisele
