module Gisele
  module Language
    module Syntax
      module WhileSt
        include Node

        def to_ast
          cond = captures[:bool_expr].first.to_ast
          dost = captures[:process_statement].first.to_ast
          [:while_st, cond, dost]
        end

      end # module WhileSt
    end # module Syntax
  end # module Language
end # module Gisele