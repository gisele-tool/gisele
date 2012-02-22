module Gisele
  Language = Sexpr.load Path.dir/"language/grammar.sexp.yml"
  module Language

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
require_relative 'language/syntax'
require_relative 'language/ast'
require_relative 'language/rewriter'
require_relative 'language/processors'
