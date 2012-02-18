module Gisele
  module Language
    class Rewriter
      class WorkOnNodes < Helper
        include AST::Helpers

        def call(rw, node, &bl)
          node = pre_call(node)
          tran = next_call(rw, node, bl)
          post_call(tran)
        end

        protected

        def pre_call(node)
          unless looks_a_node?(node)
            msg = "AST node expected, got #{node.inspect}"
            raise ArgumentError, msg, caller
          end
          node(node)
        end

        def post_call(t)
          looks_a_node?(t) ? node(t) : t
        end

      end # module WorkOnNodes
    end # class Rewriter
  end # module Language
end # module Gisele
