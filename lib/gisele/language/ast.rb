module Gisele
  module Language
    module AST

      def node(arg)
        return arg if arg.is_a?(Node)
        unless arg.is_a?(Array) && arg.first.is_a?(Symbol)
          raise ArgumentError, "Array expected, #{arg.inspect} found."
        end
        modname = Language.rule2mod(arg.first)
        mod     = const_get(modname) rescue Node
        arg.extend(mod)
      end
      module_function :node

    end # module AST
  end # module Language
end # module Gisele
require_relative 'ast/node'