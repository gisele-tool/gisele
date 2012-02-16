module Gisele
  module Language
    class Transformer
      class UnexpectedNodeError < StandardError; end

      def call(ast)
        unless non_terminal?(ast)
          raise ArgumentError, "Non terminal expected, got #{ast.inspect}"
        end
        kind = ast.first
        if respond_to? :"on_#{kind}"
          send :"on_#{kind}", *ast[1..-1]
        else
          on_missing kind, ast[1..-1]
        end
      end

      def on_missing(kind, args)
        raise UnexpectedNodeError, "Unexpected node: #{ast.first}"
      end

      protected

      def non_terminal?(node)
        node.is_a?(Array) and node.first.is_a?(Symbol)
      end

      def deep_copy(kind, args)
        args.inject [kind] do |memo,arg|
          memo << (non_terminal?(arg) ? call(arg) : arg)
        end
      end

    end # class Transformer
  end # module Language
end # module Gisele