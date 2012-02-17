require 'spec_helper'
describe "The examples" do

  (Path.backfind(".[examples]")/:examples).glob("**/*.gis").each do |file|

    describe file do
      it 'parses without any error' do
        Gisele::ast(file).should be_a(Array)
      end
    end

  end

end
