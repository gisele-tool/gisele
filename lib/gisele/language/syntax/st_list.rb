module Gisele
  module Language
    module Syntax
      module StList
        include Node

        def to_ast
          captures[:explicit_statement].map{|x| x.to_ast}
        end

      end # module StList
    end # module Syntax
  end # module Language
end # module Gisele