require 'spec_helper'
module Gisele::Language::AST
  describe BoolExpr, "negate" do

    def sexpr(expr, options = {})
      Gisele.sexpr(Gisele.parse(expr, options))
    end

    subject{ sexpr(expr, :root => :bool_expr).negate }

    shared_examples_for 'A negated bool_expr' do

      it 'is consistently rewrited' do
        (Gisele::Language[:bool_expr] === subject).should be_true
      end

      it 'is correctly tagged' do
        subject.should be_a(Sexpr)
        subject.should be_a(BoolExpr)
      end

      it 'has no immediate traceability marker' do
        subject.citrus_match.should be_nil
      end
    end

    describe "on a normal expression" do
      let(:expr){ "x and y" }

      it_behaves_like 'A negated bool_expr'

      it "negates as expected" do
        expected = sexpr("not(x and y)", :root => :bool_expr)
        subject.should eq(expected)
      end
    end

    describe "on a negated expression" do
      let(:expr){ "not(x and y)" }

      it_behaves_like 'A negated bool_expr'

      it "removes the negation" do
        expected = sexpr("x and y", :root => :bool_expr)
        subject.should eq(expected)
      end
    end

  end
end