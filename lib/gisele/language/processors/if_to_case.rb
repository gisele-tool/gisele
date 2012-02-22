module Gisele
  module Language
    class IfToCase < Sexpr::Rewriter
      grammar Language

      def on_if_st(sexpr)
        condition, dost, *clauses = sexpr.sexpr_body

        # create case_st with same markers as the if_st
        when_clause = [:when_clause, condition, main_processor.call(dost)]
        when_clause = sexpr(when_clause, sexpr.tracking_markers)
        base        = [:case_st, nil, when_clause]
        base        = sexpr(base, sexpr.tracking_markers)

        # this is the condition for elsif clauses
        @condition = negate(condition.last)

        # make injection now
        clauses.inject base do |memo,clause|
          memo << call(clause)
        end
      end

      def on_elsif_clause(sexpr)
        condition, dost, = sexpr.sexpr_body

        # install new conditions for me and next elsif clauses
        condition = condition.last
        previous  = @condition
        @condition = [:bool_and, negate(condition), @condition]

        # convert elsif to when and keep the markers
        base = \
          [:when_clause,
            [:bool_expr, [:bool_and, condition, previous]],
            main_processor.call(dost) ]
        sexpr(base, sexpr.tracking_markers)
      end

      def on_else_clause(sexpr)
        dost, = sexpr.sexpr_body

        # convert else to when and keep the markers
        base = \
          [:when_clause,
            [:bool_expr, @condition],
            main_processor.call(dost)]
        sexpr(base, sexpr.tracking_markers)
      end

      alias :on_missing :copy_and_apply

      private

      def negate(cond)
        if cond.first == :bool_not
          cond.last
        else
          [:bool_not, cond]
        end
      end

    end # class IfToCase
  end # module Language
end # module Gisele