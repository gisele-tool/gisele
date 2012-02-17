module Gisele
  module Language
    module Syntax
      module Unit
        include Node

        def to_ast
          [:unit] + captures[:task_def].map{|x| x.to_ast}
        end

      end # module Unit
    end # module Syntax
  end # module Language
end # module Gisele