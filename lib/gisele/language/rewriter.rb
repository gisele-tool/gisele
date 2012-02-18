module Gisele
  module Language
    class Rewriter

      def self.helpers
        @helpers ||= [ WorkOnNodes.new ]
      end

      def self.add_helper(helper)
        unless helpers.empty?
          helpers.last.next_in_chain = helper
        end
        helpers << helper
      end

      def call(node)
        help(node) do |n|
          meth = :"on_#{node.first}"
          meth = :"on_missing" unless respond_to?(meth)
          send(meth, node)
        end
      end

      def on_missing(node)
        raise UnexpectedNodeError, "Unexpected node: #{node.inspect}"
      end

      def copy_and_applyall(node)
        node.copy do |memo,child|
          memo << (child.is_a?(AST::Node) ? call(child) : child)
        end
      end

      private

      def help(node)
        @first_helper ||= self.class.helpers.first
        @first_helper.call(self, node) do |_,n|
          yield(n)
        end
      end

    end # class Rewriter
  end # module Language
end # module Gisele
require_relative 'rewriter/helper'
require_relative 'rewriter/work_on_nodes'
require_relative 'rewriter/scoping'
