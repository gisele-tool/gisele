module Gisele
  module Language
    class SugarRemoval < Transformer
      alias :on_missing :deep_copy

      def on_if(*args)
        IfToGuardedCommands.new(self).call(args.unshift :if)
      end

      class IfToGuardedCommands < Transformer

        def initialize(main)
          @main = main
        end

        def on_if(condition, dost, *clauses)
          @condition = condition
          base = [:case, [:when, @condition, @main.call(dost)] ]
          clauses.inject base do |memo,clause|
            memo << call(clause)
          end
        end

        def on_elsif(condition, dost)
          prev, @condition = @condition, [:and, @condition, condition]
          [:when, 
            [:and, condition, [:not, prev]],
            @main.call(dost)]
        end

        def on_else(dost)
          [:when,
            [:not, @condition],
            @main.call(dost)]
        end

      end # class IfToGuardedCommands
    end # class SugarRemoval
  end # module Language
end # module Gisele