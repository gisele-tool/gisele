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

    # The tagging function (from s-expr kind to AST module) is not complete so far.
    # This allows us to at least include the AST:Node module in all s-expressions.
    def default_tagging_module
      AST::Node
    end

    require 'yaml'
    DOT_ATTRIBUTES = YAML.load_file(Path.dir/"language/grammar.dot.yml")

  end # module Language
end # module Gisele