module Gisele
  module Language
    module Syntax
      module Node

        def value
          to_ast
        end

      end # module Node
    end # module Syntax
  end # module Language
end # module Gisele
require_relative 'event_set'
require_relative 'fluent_def'
require_relative 'trackvar_def'
require_relative 'var_ref'
require_relative 'bool_lit'
require_relative 'bool_paren'
require_relative 'bool_not'
require_relative 'bool_and'
require_relative 'bool_or'
require_relative 'st_list'
require_relative 'implicit_seq_st'
require_relative 'task_call_st'
require_relative 'seq_st'
require_relative 'par_st'
require_relative 'while_st'
require_relative 'if_st'
require_relative 'else_clause'
require_relative 'elsif_clause'
require_relative 'task_refinement'
require_relative 'task_signature'
require_relative 'task_def'
require_relative 'unit'
