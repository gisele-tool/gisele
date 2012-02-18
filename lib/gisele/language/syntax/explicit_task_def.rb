module Gisele
  module Language
    module Syntax
      module ExplicitTaskDef
        include Node

        def _to_ast
          name = captures[:task_name].first.strip
          sig  = captures[:task_signature].map{|x| x.to_ast}.first || [:task_signature]
          ref  = captures[:task_refinement].map{|x| x.to_ast}.first || [:task_refinement]
          [:task_def, name, sig, ref]
        end

      end # module ExplicitTaskDef
    end # module Syntax
  end # module Language
end # module Gisele