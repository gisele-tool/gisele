module Gisele
  module Language
    module Syntax
      module BoolExpr
        include Node

        def _to_ast
          [:bool_expr, captures[:theexpr].first.to_ast]
        end

      end # module BoolExpr
    end # module Syntax
  end # module Language
end # module Gisele