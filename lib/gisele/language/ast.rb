module Gisele
  module Language
    module AST

      def node(arg)
        return arg if arg.is_a?(Node)
        unless looks_a_node?(arg)
          raise ArgumentError, "Array expected, #{arg.inspect} found."
        end
        extend_node(arg).tap do |node|
          node.children.each{|c| node(c) if looks_a_node?(c)}
        end
      end

      private

      def looks_a_node?(arg)
        arg.is_a?(Node) or (arg.is_a?(Array) and arg.first.is_a?(Symbol))
      end

      def extend_node(arg)
        modname = Language.rule2mod(arg.first)
        mod     = const_get(modname) rescue Node
        arg.extend(mod)
      end

      extend(self)
    end # module AST
  end # module Language
end # module Gisele
require_relative 'ast/node'