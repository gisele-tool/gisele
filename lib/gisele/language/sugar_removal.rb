module Gisele
  module Language
    class SugarRemoval < Rewriter
      alias :on_missing :copy_and_applyall

      def on_if_st(node)
        IfToCase.new(:mainflow => self).call(node)
      end

    end # class SugarRemoval
  end # module Language
end # module Gisele
