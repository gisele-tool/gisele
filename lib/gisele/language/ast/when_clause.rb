module Gisele
  module Language
    module AST
      module WhenClause
        include Node

        def label
          self[1].label
        end

      end # module WhenClause
    end # module AST
  end # module Language
end # module Gisele