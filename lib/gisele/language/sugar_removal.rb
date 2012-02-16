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
          base = [:case, [:when, condition, @main.call(dost)] ]
          @condition = [:not, condition]
          clauses.inject base do |memo,clause|
            memo << call(clause)
          end
        end

        def on_elsif(condition, dost)
          prev, @condition = @condition, [:and, [:not, condition], @condition]
          [:when,
            [:and, condition, prev],
            @main.call(dost)]
        end

        def on_else(dost)
          [:when,
            @condition,
            @main.call(dost)]
        end

      end # class IfToGuardedCommands
    end # class SugarRemoval
  end # module Language
end # module Gisele
