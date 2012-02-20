module Gisele
  module Language
    module AST
      module Node

        # Returns the node markers
        def markers
          @markers ||= {}
        end

        # Sets node markers
        def markers=(markers)
          @markers = markers
        end

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

        # Returns the associated ast_module
        def ast_module
          AST::Helpers.send(:ast_module, self)
        end

        # Applies copy-and-transform to this node.
        #
        # Example:
        #   node = AST.node([:something, "world", [:subnode ...]])
        #   node.copy do |base,child|
        #     base << ... make something with child ...
        #   end
        #   # => [:something, ...]
        #
        def copy(&block)
          base = AST.node([rule_name], markers.dup)
          children.inject(base, &block)
        end

        # Duplicates this node.
        #
        # This method ensures that the node marking through modules
        # will correctly be applied to the duplicated array.
        #
        def dup
          AST.node(super, markers.dup)
        end

        # Returns a label for this AST node
        def label
          ""
        end

        # Returns attributes to use for dot printing
        def dot_attributes
          attrs = Language::DOT_ATTRIBUTES[rule_name.to_s] || {}
          attrs.merge(:label => label)
        end

        # Checks validity over the definition
        def ===(sexp)
          SEXP_GRAMMAR[rule_name] === sexp
        end

      end # module Node
    end # module AST
  end # module Language
end # module Gisele
require_relative 'unit_def'
require_relative 'task_call_st'
require_relative 'while_st'
require_relative 'if_st'
require_relative 'else_clause'
require_relative 'elsif_clause'
require_relative 'case_st'
require_relative 'when_clause'
require_relative 'bool_expr'
require_relative 'bool_and'
require_relative 'bool_or'
require_relative 'bool_not'
require_relative 'var_ref'
