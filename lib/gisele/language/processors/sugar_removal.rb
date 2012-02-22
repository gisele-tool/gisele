module Gisele
  module Language
    class SugarRemoval < Sexpr::Rewriter
      grammar Language

      def on_if_st(sexpr)
        ElsifFlattener.new(:main_processor => self).call(sexpr)
      end

      alias :on_missing :copy_and_apply

    end # class SugarRemoval
  end # module Language
end # module Gisele