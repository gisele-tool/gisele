module Gisele
  module Language
    module Syntax
      module SeqSt
        include Node

        def _to_ast
          [:seq_st] + captures[:st_list].first.value
        end

      end # module SeqSt
    end # module Syntax
  end # module Language
end # module Gisele