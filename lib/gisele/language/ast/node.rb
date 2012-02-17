module Gisele
  module Language
    module AST
      module Node

        # Returns the rule name, that is, the first Symbol element
        # of the node array.
        #
        # Example:
        #     file = ... path to a .gis file ...
        #     Gisele.ast(file).rule_name
        #     # => :unit
        #
        def rule_name
          first
        end

        # Duplicates this node.
        #
        # This method ensures that the node marking through modules 
        # will correctly be applied to the duplicated array.
        #
        def dup
          AST.node(super)
        end

      end # module Node
    end # module AST
  end # module Language
end # module Gisele
require_relative 'unit'