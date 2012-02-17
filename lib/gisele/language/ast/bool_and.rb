module Gisele
  module Language
    module AST
      module BoolAnd
        include Node

        def label
          markers[:match] ? markers[:match].to_s : "(#{self[1].label} and #{self[2].label})"
        end

      end # module BoolAnd
    end # module AST
  end # module Language
end # module Gisele