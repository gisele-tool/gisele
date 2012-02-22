module Gisele
  Language = Sexpr.load Path.dir/"language/grammar.sexp.yml"

  # force the loading of the citrus parser
  require_relative 'language/syntax'
  Language.parser.parser

  module Language

    require_relative 'language/ast'
    def tagging_reference
      AST
    end

    require 'yaml'
    DOT_ATTRIBUTES = YAML.load_file(Path.dir/"language/grammar.dot.yml")

    RESERVED_WORDS = [
      "if",
      "else",
      "elsif",
      "when",
      "while",
      "seq",
      "par",
      "task",
      "refinement",
      "fluent",
      "trackvar",
      "initially",
      "end",
      "not",
      "or",
      "and",
      "true",
      "false"
    ]

  end # module Language
end # module Gisele
require_relative 'language/processors'
