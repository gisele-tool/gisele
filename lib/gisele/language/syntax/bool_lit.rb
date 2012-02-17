module Gisele
  module Language
    module Syntax
      module BoolLit
        include Node

        def _to_ast
          captures[:boolean_literal].first.value
        end

      end # module BoolLit
    end # module Syntax
  end # module Language
end # module Gisele