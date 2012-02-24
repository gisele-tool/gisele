module Gisele
  module Language
    module AST
      module Node

        def citrus_match
          tracking_markers[:citrus_match]
        end

        # Returns a label for this AST node
        def label
          ""
        end

        # Checks validity over the definition
        def ===(sexp)
          Language[rule_name] === sexp
        end

      end # module Node
    end # module AST
  end # module Language
end # module Gisele
require_relative 'task_call_st'
require_relative 'while_st'
require_relative 'if_st'
require_relative 'else_clause'
require_relative 'elsif_clause'
require_relative 'case_st'
require_relative 'when_clause'
require_relative 'bool_expr'
require_relative 'bool_and'
require_relative 'bool_or'
require_relative 'bool_not'
require_relative 'var_ref'