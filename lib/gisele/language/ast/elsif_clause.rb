module Gisele
  module Language
    module AST
      module ElsifClause
        include Node

        def label
          self[1].label
        end

      end # module ElsifClause
    end # module AST
  end # module Language
end # module Gisele