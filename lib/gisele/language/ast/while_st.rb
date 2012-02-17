module Gisele
  module Language
    module AST
      module WhileSt
        include Node

        def label
          self[1].label
        end

      end # module WhileSt
    end # module AST
  end # module Language
end # module Gisele