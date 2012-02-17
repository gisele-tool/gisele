module Gisele
  module Language
    module Syntax
      module VarRef
        include Node

        def _to_ast
          [:var_ref, strip]
        end

      end # module VarRef
    end # module Syntax
  end # module Language
end # module Gisele