module Gisele
  module Language
    module Syntax
      module BoolParen
        include Node

        def to_ast
          captures[:expr].first.to_ast
        end

      end # module BoolParen
    end # module Syntax
  end # module Language
end # module Gisele