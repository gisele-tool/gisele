module Gisele
  module Language
    module Syntax
      module TaskRefinement
        include Node

        def to_ast
          main = captures[:process_statement].first.to_ast
          [:task_refinement, main]
        end

      end # module TaskRefinement
    end # module Syntax
  end # module Language
end # module Gisele