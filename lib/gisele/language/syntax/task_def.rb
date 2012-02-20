module Gisele
  module Language
    module Syntax
      module TaskDef
        include Node

        def _to_ast
          name  = captures[:task_name].first.strip
          defs  = captures[:some_def].map{|x| x.to_ast}
          ref   = captures[:explicit_statement].map{|x| x.to_ast}.first
          ref   = [:nop_st] unless ref
          [:task_def, name] + defs + [ref]
        end

      end # module TaskDef
    end # module Syntax
  end # module Language
end # module Gisele