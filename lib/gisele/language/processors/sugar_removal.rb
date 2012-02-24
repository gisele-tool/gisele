module Gisele
  module Language
    class SugarRemoval < Sexpr::Rewriter
      grammar Language

      # (elsif ... -> else if ...)
      use ElsifFlattener

      def apply(sexpr)
        # all is already done by preprocessors so that we can simply return
        # the s-expression.
        sexpr
      end

    end # class SugarRemoval
  end # module Language
end # module Gisele