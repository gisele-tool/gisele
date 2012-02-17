module Gisele
  module Language
    module AST
      module BoolOr
        include Node

        def label
          markers[:match] ? markers[:match].to_s : "(#{self[1].label} or #{self[2].label})"
        end

      end # module BoolOr
    end # module AST
  end # module Language
end # module Gisele