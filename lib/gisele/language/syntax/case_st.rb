module Gisele
  module Language
    module Syntax
      module CaseSt
        include Node

        def _to_ast
          var     = captures[:var_ref].first
          var     = var.to_ast if var
          var     = nil if var && var.empty?
          whens   = captures[:when_clause].map{|x| x.to_ast}
          els     = captures[:else_clause].map{|x| x.to_ast}
          [:case_st, var] + whens + els
        end

      end # module CaseSt
    end # module Syntax
  end # module Language
end # module Gisele
