module Gisele
  module Language
    class ElsifFlattener < Rewriter
      alias :on_missing :copy_and_applyall

      def on_if_st(node)
        condition, dost, *clauses = node.children

        base = [:if_st, condition, dost]
        base = node(base, node.markers.dup)

        clauses.inject base do |cur_if, clause|
          rw_clause = call(clause)
          cur_if << rw_clause
          rw_clause.last
        end

        base
      end

      def on_elsif_clause(node)
        base = \
          [:else_clause,
           [:if_st, node[1], mainflow.call(node[2])] ]
        base = node(base, node.markers.dup)
      end

      def on_else_clause(node)
        [:else_clause, mainflow.call(node.last)]
      end

    end # class ElsifFlattener
  end # module Language
end # module Gisele

