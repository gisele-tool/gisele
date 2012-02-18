module Gisele
  module Language
    module Syntax
      module ImplicitTaskDef
        include Node

        def _to_ast
          name = captures[:task_name].first.strip
          ref = captures[:process_statement].map{|x| x.to_ast}.first
          ref = ref.nil? ? [:task_refinement] : [:task_refinement, ref]
          [:task_def, name, [:task_signature], ref]
        end

      end # module ImplicitTaskDef
    end # module Syntax
  end # module Language
end # module Gisele
