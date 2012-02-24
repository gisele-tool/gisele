module Gisele
  module Language
    module AST
      module BoolExpr
        include Node

        def label
          (citrus_match && citrus_match.to_s) || last.label
        end

        def negate
          if last.first == :bool_not
            Language.sexpr [:bool_expr, last.last]
          else
            Language.sexpr [ :bool_expr, [:bool_not, last] ]
          end
        end

      end # module BoolExpr
    end # module AST
  end # module Language
end # module Gisele