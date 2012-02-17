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

        def dup
          super.extend(most_specific_module)
        end

        private

        # Returns the most specific module to use for this node
        def most_specific_module
          mod_name = Language.rule2mod(rule_name)
          AST.const_get(mod_name) rescue Node
        end

      end # module Node
    end # module AST
  end # module Language
end # module Gisele
require_relative 'unit'