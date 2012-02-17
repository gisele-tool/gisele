module Gisele
  module Language
    class Transformer
      include AST::Helpers

      def call(node)
        node = pre_call(node)
        meth = :"on_#{node.rule_name}"
        meth = :"on_missing" unless respond_to?(meth)
        post_call send(meth, node)
      end

      def on_missing(node)
        raise UnexpectedNodeError, "Unexpected node: #{node.rule_name}"
      end

      protected

      def pre_call(node)
        unless looks_a_node?(node)
          raise ArgumentError, "AST node expected, got #{node.inspect}", caller
        end
        node(node)
      end

      def post_call(transformed)
        looks_a_node?(transformed) ? node(transformed) : transformed
      end

      def copy_and_applyall(node)
        node.copy do |memo,child|
          memo << (child.is_a?(AST::Node) ? call(child) : child)
        end
      end

    end # class Transformer
  end # module Language
end # module Gisele