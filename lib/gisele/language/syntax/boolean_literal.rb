module Gisele
  module Language
    module Syntax
      module BooleanLiteral
        include Node

        def to_ast
          strip == "true" ? true : false
        end

      end # module BooleanLiteral
    end # module Syntax
  end # module Language
end # module Gisele