module Gisele
  module Language
    Citrus.load(File.expand_path('../grammar', __FILE__))
    class Parser

      def self.parse(input)
        new.parse(input)
      end

      def call(input)
        return input if input.is_a?(Array)
        grammar.parse(parsing_source(input)).to_ast
      end
      alias :parse :call

      private

      def grammar
        Gisele::Language::Grammar
      end

      def parsing_source(input)
        input = File.read(input.to_path) if input.respond_to?(:to_path)
        input = input.to_str if input.respond_to?(:to_str)
        input
      end

    end # class Parser
  end # module Language
end # module Gisele