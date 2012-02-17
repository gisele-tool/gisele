module Gisele
  module Language
    module AST
      module BoolNot
        include Node

        def label
          markers[:match] ? markers[:match].to_s : "not(#{last.label})"
        end

      end # module BoolNot
    end # module AST
  end # module Language
end # module Gisele