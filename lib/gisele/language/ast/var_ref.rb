module Gisele
  module Language
    module AST
      module VarRef
        include Node

        def label
          last.to_s
        end

      end # module BoolNot
    end # module AST
  end # module Language
end # module Gisele