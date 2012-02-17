module Gisele
  module Language
    module Syntax
      module ImplicitSeqSt
        include Node

        def _to_ast
          front = captures[:explicit_statement].first.to_ast
          tail  = captures[:st_list].first.to_ast
          [:seq_st, front] + tail
        end

      end # module ImplicitSeqSt
    end # module Syntax
  end # module Language
end # module Gisele