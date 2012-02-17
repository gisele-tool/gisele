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
require_relative 'boolean_literal'
require_relative 'event_set'
require_relative 'fluent_def'
require_relative 'trackvar_def'