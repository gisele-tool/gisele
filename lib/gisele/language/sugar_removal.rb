module Gisele
  module Language
    class SugarRemoval < Transformer
      alias :on_missing :deep_copy

      def on_if(node)
        IfToGuardedCommands.new(self).call(node)
      end

      class IfToGuardedCommands < Transformer

        def initialize(main)
          @main = main
        end

        def on_if(node)
          condition, dost, *clauses = node.children
          base = [:case, [:when, condition, @main.call(dost)] ]
          @condition = [:not, condition]
          clauses.inject base do |memo,clause|
            memo << call(clause)
          end
        end

        def on_elsif(node)
          condition, dost, = node.children
          prev, @condition = @condition, [:and, [:not, condition], @condition]
          [:when,
            [:and, condition, prev],
            @main.call(dost)]
        end

        def on_else(node)
          dost, = node.children
          [:when,
            @condition,
            @main.call(dost)]
        end

      end # class IfToGuardedCommands
    end # class SugarRemoval
  end # module Language
end # module Gisele
