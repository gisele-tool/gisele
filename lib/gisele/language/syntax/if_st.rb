module Gisele
  module Language
    module Syntax
      module IfSt
        include Node

        def to_ast
          cond    = captures[:bool_expr].first.to_ast
          dost    = captures[:process_statement].first.to_ast
          elsifs  = captures[:elsif_clause].map{|x| x.to_ast}
          els     = captures[:else_clause].map{|x| x.to_ast}
          [:if_st, cond, dost] + elsifs + els
        end

      end # module IfSt
    end # module Syntax
  end # module Language
end # module Gisele