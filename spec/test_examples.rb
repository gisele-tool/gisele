require 'spec_helper'
describe "The examples" do

  (Path.backfind(".[examples]")/:examples).glob("**/*.gis").each do |file|

    describe file do

      let(:ast){ Gisele::ast(file) }

      it 'parses without any error' do
        ast.should be_a(Array)
      end

      it 'respects the SexpGrammar' do
        (Gisele::Language::SEXP_GRAMMAR === ast).should be_true
      end

    end

  end

end
