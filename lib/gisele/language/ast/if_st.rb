module Gisele
  module Language
    module AST
      module IfSt
        include Node

        def label
          self[1].label
        end

      end # module IfSt
    end # module AST
  end # module Language
end # module Gisele