module Gisele
  module Language
    module AST
      module CaseSt
        include Node

        def label
          (self[1] && self[1].label) || ""
        end

      end # module CaseSt
    end # module AST
  end # module Language
end # module Gisele