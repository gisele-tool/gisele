module Gisele
  module Language
    module AST
      module Helpers

        def ast(arg, markers = {})
          return node(arg, markers) if looks_a_node?(arg)
          ast(Syntax.ast(arg), markers)
        end

        def node(arg, markers = {})
          return arg if arg.is_a?(Node)
          unless looks_a_node?(arg)
            raise ArgumentError, "Array expected, #{arg.inspect} found."
          end
          extend_node(arg, markers).tap do |node|
            node.children.each{|c| node(c) if looks_a_node?(c)}
          end
        end

        private

        def looks_a_node?(arg)
          arg.is_a?(Node) or (arg.is_a?(Array) and arg.first.is_a?(Symbol))
        end

        def extend_node(arg, markers)
          mod = ast_module(arg)
          arg.extend(mod).tap do |node|
            node.markers = markers
          end
        end

        def ast_module(node)
          modname = Language.rule2modname(node.first)
          AST.const_get(modname) rescue Node
        end

        extend(self)
      end # module Helpers
    end # module AST
  end # module Language
end # module Gisele