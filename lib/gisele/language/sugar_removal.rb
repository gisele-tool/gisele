module Gisele
  module Language
    class SugarRemoval < Transformer
      alias :on_missing :copy_and_applyall

      def on_if_st(node)
        IfToGuardedCommands.new(self).call(node)
      end

      class IfToGuardedCommands < Transformer

        def initialize(main)
          @main = main
        end

        def on_if_st(node)
          condition, dost, *clauses = node.children
          base = [:case_st, [:when_clause, condition, @main.call(dost)] ]
          @condition = negate(condition.last)
          clauses.inject base do |memo,clause|
            memo << call(clause)
          end
        end

        def on_elsif_clause(node)
          condition, dost, = node.children
          condition = condition.last
          prev, @condition = @condition, [:bool_and, negate(condition), @condition]
          [:when_clause,
            [:bool_expr, [:bool_and, condition, prev]],
            @main.call(dost)]
        end

        def on_else_clause(node)
          dost, = node.children
          [:when_clause,
            [:bool_expr, @condition],
            @main.call(dost)]
        end

        private

        def negate(cond)
          if cond.rule_name == :bool_not
            cond.last
          else
            [:bool_not, cond]
          end
        end

      end # class IfToGuardedCommands
    end # class SugarRemoval
  end # module Language
end # module Gisele
