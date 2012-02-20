module Gisele
  module Language
    module Syntax
      module UnitDef
        include Node

        def _to_ast
          [:unit_def] + captures[:task_def].map{|x| x.to_ast}
        end

      end # module UnitDef
    end # module Syntax
  end # module Language
end # module Gisele