module Gisele
  module Language
    module Syntax
      module TrackvarDef
        include Node

        def _to_ast
          name       = captures[:variable_name].first.strip
          init, term = captures[:event_set].map{|x| x.to_ast}
          term       = [:event_set] unless term
          initval    = captures[:initially_def].first
          initval    = (initval && !initval.empty?) ? initval.value : nil
          [:trackvar, name, init, term, initval]
        end

      end # module TrackvarDef
    end # module Syntax
  end # module Language
end # module Gisele