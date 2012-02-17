module Gisele
  module Language
    class Transformer
      include AST::Helpers

      class UnexpectedNodeError < StandardError; end

      def call(node)
        unless looks_a_node?(node)
          raise ArgumentError, "AST node expected, got #{node.inspect}"
        end
        node = node(node)
        meth = :"on_#{node.rule_name}"
        meth = :"on_missing" unless respond_to?(meth)
        send(meth, node)
      end

      def on_missing(node)
        raise UnexpectedNodeError, "Unexpected node: #{node.rule_name}"
      end

      protected

      def deep_copy(node)
        copy = AST::node([node.rule_name])
        node.children.inject copy do |memo,child|
          memo << (child.is_a?(AST::Node) ? call(child) : child)
        end
      end

    end # class Transformer
  end # module Language
end # module Gisele