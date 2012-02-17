module Gisele
  module Language
    module Syntax
      module BoolAnd
        include Node

        def to_ast
          [:bool_and, left.to_ast, right.to_ast]
        end

      end # module BoolAnd
    end # module Syntax
  end # module Language
end # module Gisele