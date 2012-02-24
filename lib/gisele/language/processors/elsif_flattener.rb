module Gisele
  module Language
    class ElsifFlattener < Sexpr::Rewriter
      grammar Language

      def on_if_st(sexpr)
        condition, dost, *clauses = sexpr.sexpr_body

        base = [:if_st, condition, dost]
        base = sexpr(base, sexpr.tracking_markers)

        clauses.inject base do |cur_if, clause|
          rw_clause = apply(clause)
          cur_if << rw_clause
          rw_clause.last
        end

        base
      end

      def on_elsif_clause(sexpr)
        base = \
          [:else_clause,
           [:if_st, sexpr[1], apply(sexpr[2])] ]
        base = sexpr(base, sexpr.tracking_markers)
      end

      def on_else_clause(sexpr)
        [:else_clause, apply(sexpr.last)]
      end

      alias :on_missing :copy_and_apply

    end # class ElsifFlattener
  end # module Language
end # module Gisele