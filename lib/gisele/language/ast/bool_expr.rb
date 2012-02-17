module Gisele
  module Language
    module AST
      module BoolExpr
        include Node

        def label
          markers[:match] ? markers[:match].to_s : last.label
        end

      end # module BoolExpr
    end # module AST
  end # module Language
end # module Gisele