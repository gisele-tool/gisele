module Gisele
  module Language
    module Syntax
      module BoolOr
        include Node

        def _to_ast
          [:bool_or, left.to_ast, right.to_ast]
        end

      end # module BoolOr
    end # module Syntax
  end # module Language
end # module Gisele