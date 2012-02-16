module Gisele
  module Language
    class Transformer
      class UnexpectedNodeError < StandardError; end

      def call(ast)
        unless ast.is_a? Array
          raise ArgumentError, "Array expected, got #{ast}"
        end
        unless ast.first.is_a? Symbol
          raise ArgumentError, "Non terminal expected, got #{ast.inspect}"
        end
        kind = ast.first
        if respond_to? :"on_#{kind}"
          send :"on_#{kind}", ast[1..-1]
        else
          on_missing kind, ast[1..-1]
        end
      end

      def on_missing(kind, args)
        raise UnexpectedNodeError, "Unexpected node: #{ast.first}"
      end

    end # class Transformer
  end # module Language
end # module Gisele