module Gisele
  module Language
    class SugarRemoval < Rewriter
      alias :on_missing :copy_and_applyall

      def on_if_st(node)
        IfToGuardedCommands.new(self).call(node)
      end

      class IfToGuardedCommands < Rewriter
        alias :on_missing :copy_and_applyall

        def initialize(parent = nil)
          @parent = parent || self
        end

        def on_if_st(node)
          condition, dost, *clauses = node.children

          # create case_st with same markers as the if_st
          when_clause = [:when_clause, condition, @parent.call(dost)]
          when_clause = node(when_clause, node.markers.dup)
          base        = [:case_st, when_clause]
          base        = node(base, node.markers.dup)

          # this is the condition for elsif clauses
          @condition = negate(condition.last)

          # make injection now
          clauses.inject base do |memo,clause|
            memo << call(clause)
          end
        end

        def on_elsif_clause(node)
          condition, dost, = node.children

          # install new conditions for me and next elsif clauses
          condition = condition.last
          previous  = @condition
          @condition = [:bool_and, negate(condition), @condition]

          # convert elsif to when and keep the markers
          base = \
            [:when_clause,
              [:bool_expr, [:bool_and, condition, previous]],
              @parent.call(dost) ]
          node(base, node.markers.dup)
        end

        def on_else_clause(node)
          dost, = node.children

          # convert else to when and keep the markers
          base = \
            [:when_clause,
              [:bool_expr, @condition],
              @parent.call(dost)]
          node(base, node.markers.dup)
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
