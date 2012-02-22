module Gisele
  module Language
    module AST
      module BoolNot
        include Node

        def label
          (citrus_match && citrus_match.to_s) || "not(#{last.label})"
        end

      end # module BoolNot
    end # module AST
  end # module Language
end # module Gisele