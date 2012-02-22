module Gisele
  module Language
    module AST
      module ElseClause
        include Node

        def label
          "[else]"
        end

      end # module ElseClause
    end # module AST
  end # module Language
end # module Gisele