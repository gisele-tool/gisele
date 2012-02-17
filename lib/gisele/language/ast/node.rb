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

        # Returns the children of this node.
        #
        # Children are defined as all but the rule name in the underlying
        # array.
        #
        def children
          self[1..-1]
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