module Gisele
  module Language
    module Syntax
      module TaskSignature
        include Node

        def to_ast
          list = captures[:task_signature_element].map{|x| x.to_ast}
          [:task_signature] + list
        end

      end # module TaskSignature
    end # module Syntax
  end # module Language
end # module Gisele