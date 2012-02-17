module Gisele
  module Language
    module Syntax
      module EventSet
        include Node

        def to_ast
          events = (captures[:event] || []).map{|e| e.value}
          [:event_set] + events
        end

      end # module EventSet
    end # module Syntax
  end # module Language
end # module Gisele