module Gisele
  module Language
    module Syntax
      module ElseClause
        include Node

        def _to_ast
          [:else_clause, captures[:process_statement].first.to_ast]
        end

      end # module ElseClause
    end # module Syntax
  end # module Language
end # module Gisele