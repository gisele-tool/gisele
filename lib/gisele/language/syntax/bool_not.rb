module Gisele
  module Language
    module Syntax
      module BoolNot
        include Node

        def _to_ast
          [:bool_not, captures[:expr].first.to_ast]
        end

      end # module BoolParen
    end # module Syntax
  end # module Language
end # module Gisele