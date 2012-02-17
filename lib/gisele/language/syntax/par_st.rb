module Gisele
  module Language
    module Syntax
      module ParSt
        include Node

        def _to_ast
          [:par_st] + captures[:st_list].first.to_ast
        end

      end # module ParSt
    end # module Syntax
  end # module Language
end # module Gisele