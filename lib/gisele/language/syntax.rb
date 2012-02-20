require_relative 'syntax/node'
module Gisele
  module Language
    module Syntax
      Citrus.load(File.expand_path('../grammar', __FILE__))

      def parse(input, options = {})
        source = parsing_source(input)
        Grammar.parse(source, options)
      end
      module_function :parse

      def ast(input, parse_options = {})
        parse(input, parse_options).to_ast
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