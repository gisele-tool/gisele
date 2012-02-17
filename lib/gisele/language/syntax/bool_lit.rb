module Gisele
  module Language
    module Syntax
      module BoolLit
        include Node

        def _to_ast
          [:bool_lit, strip == "true"]
        end

      end # module BoolLit
    end # module Syntax
  end # module Language
end # module Gisele