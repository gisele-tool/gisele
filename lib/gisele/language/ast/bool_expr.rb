module Gisele
  module Language
    module AST
      module BoolExpr
        include Node

        def label
          (citrus_match && citrus_match.to_s) || last.label
        end

      end # module BoolExpr
    end # module AST
  end # module Language
end # module Gisele