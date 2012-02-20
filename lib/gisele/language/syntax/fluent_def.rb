module Gisele
  module Language
    module Syntax
      module FluentDef
        include Node

        def _to_ast
          name       = captures[:variable_name].first.strip
          init, term = captures[:event_set].map{|x| x.to_ast}
          initval    = captures[:initially_def].first
          initval    = (initval && !initval.empty?) ? initval.value : nil
          [:fluent_def, name, init, term, initval]
        end

      end # module FluentDef
    end # module Syntax
  end # module Language
end # module Gisele