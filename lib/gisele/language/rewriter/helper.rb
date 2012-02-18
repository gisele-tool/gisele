module Gisele
  module Language
    class Rewriter
      class Helper

        attr_accessor :next_in_chain

        def self.install_on(rewriter)
          methods = const_get(:Methods)
          rewriter.module_eval do
            include methods
          end
          rewriter.add_helper(new)
        end

        def call(rw, node, &bl)
          meth = :"on_#{node.first}"
          meth = :"on_missing" unless respond_to?(meth)
          send(meth, rw, node) do |r,n|
            next_call(r, n, bl)
          end
        end

        def on_missing(rw, node)
          yield(rw, node)
        end

        private

        def next_call(rw, node, toplevel)
          if nic = next_in_chain
            nic.call(rw, node, &toplevel)
          else
            toplevel.call(rw, node)
          end
        end

      end # class Helper
    end # class Rewriter
  end # module Language
end # module Gisele
