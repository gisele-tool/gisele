require_relative 'syntax/node'
module Gisele
  module Language
    module Syntax
      Citrus.load(File.expand_path('../syntax/grammar', __FILE__))

      def parse(input)
        source = parsing_source(input)
        Grammar.parse(source)
      end
      module_function :parse

      def ast(input)
        parse(input).to_ast
      end
      module_function :ast

      private

      def parsing_source(input)
        input = File.read(input.to_path) if input.respond_to?(:to_path)
        input = input.to_str if input.respond_to?(:to_str)
        input
      end
      module_function :parsing_source

    end # module Syntax
  end # module Language
end # module Gisele