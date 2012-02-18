require 'spec_helper'
module Gisele::Language
  class Rewriter
    describe Helper do

      class FooHelper < Helper
        module Methods end

        def on_hello(rw, node)
          raise unless rw.is_a?(FooRewriter)
          [:foo_hello, yield(rw, node)]
        end

      end

      class FooRewriter < Rewriter
        FooHelper.install_on(self)
      end

      describe "install_on" do

        it 'installs the methods module on the rewriter' do
          modules = FooRewriter.included_modules
          modules.include?(FooHelper::Methods).should be_true
        end

        it 'adds an instance of the helper to the helpers list' do
          helper = FooRewriter.helpers.last
          helper.should be_a(FooHelper)
        end

        it 'does not polute the Rewriter class' do
          Rewriter.helpers.size.should eq(1)
        end

      end # install_on

      describe 'call' do

        let(:helper)   { FooHelper.new   }
        let(:rewriter) { FooRewriter.new }
        let(:toplevel) {
          Proc.new do |rw,node|
            rw.should eq(rewriter)
            [:toplevel, node]
          end
        }

        it 'dispatches to the method when it exists' do
          expected = \
            [:foo_hello,
              [:toplevel,
                [:hello, "world"] ]]
          got = helper.call(rewriter, [:hello, "world"], &toplevel)
          got.should eq(expected)
        end

        it 'falls back to yielding when no method' do
          expected = \
            [:toplevel,
              [:nosuchone] ]
          got = helper.call(rewriter, [:nosuchone], &toplevel)
          got.should eq(expected)
        end

        it 'calls next_in_chain when set' do
          helper.next_in_chain = Class.new do
            def call(rw, node)
              raise unless rw.is_a?(FooRewriter)
              yield rw, [:next, node]
            end
          end.new

          expected = \
            [:foo_hello,
              [:toplevel,
                [:next,
                  [:hello, "world"] ]]]
          got = helper.call(rewriter, [:hello, "world"], &toplevel)
          got.should eq(expected)
        end

      end # call

    end
  end
end
