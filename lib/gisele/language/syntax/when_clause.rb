module Gisele
  module Language
    module Syntax
      module WhenClause
        include Node

        def _to_ast
          cond = captures[:bool_expr].first.to_ast
          dost = captures[:process_statement].first.to_ast
          [:when_clause, cond, dost]
        end

      end # module WhenClause
    end # module Syntax
  end # module Language
end # module Gisele