module Gisele

  # Load the Language through Sexpr
  Language = Sexpr.load Path.dir/"language/grammar.sexp.yml"

  # Load syntax nodes, abstract syntax nodes, and processors
  require_relative 'language/syntax/node'
  require_relative 'language/ast/node'
  require_relative 'language/processors'

  # Force loading the Citrus parser now
  Language.parser.parser

  module Language

    # By default, Sexpr will find for abstract nodes under Language itself. We
    # override that behavior here and let it know that the AST module is the
    # parent of all ast nodes.
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