module Gisele
  module Language
    module Syntax
      module TaskDef
        include Node

        def to_ast
          name = captures[:task_name].first.strip
          sig  = captures[:task_signature].map{|x| x.to_ast}.first || [:task_signature]
          ref  = captures[:task_refinement].map{|x| x.to_ast}.first || [:task_refinement]
          [:task_def, name, sig, ref]
        end

      end # module TaskDef
    end # module Syntax
  end # module Language
end # module Gisele