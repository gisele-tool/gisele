module Gisele
  module Language
    module AST

      def node(arg)
        AST::Helpers.node(arg)
      end
      module_function :node

    end # module AST
  end # module Language
end # module Gisele
require_relative 'ast/helpers'
require_relative 'ast/node'