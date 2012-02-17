module Gisele
  module Language
    module Syntax
      module ElsifClause
        include Node

        def _to_ast
          cond = captures[:bool_expr].first.to_ast
          dost = captures[:process_statement].first.to_ast
          [:elsif_clause, cond, dost]
        end

      end # module ElsifClause
    end # module Syntax
  end # module Language
end # module Gisele