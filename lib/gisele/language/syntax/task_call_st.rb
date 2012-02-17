module Gisele
  module Language
    module Syntax
      module TaskCallSt
        include Node

        def to_ast
          [:task_call_st, strip]
        end

      end # module TaskCallSt
    end # module Syntax
  end # module Language
end # module Gisele