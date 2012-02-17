module Gisele
  module Language
    module AST
      module TaskCallSt
        include Node

        def label
          last.to_s
        end

      end # module TaskCallSt
    end # module AST
  end # module Language
end # module Gisele