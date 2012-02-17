module Gisele
  module Language
    module AST
      module TaskCallSt
        include Node

        def label
          self[1]
        end

      end # module TaskCallSt
    end # module AST
  end # module Language
end # module Gisele