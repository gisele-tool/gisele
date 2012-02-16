require 'spec_helper'
require 'gisele/command'
module Gisele
  describe 'the `gisele` commandline tool' do

    Path.dir.glob("**/*.cmd").each do |cmdfile|

      it "executes `#{cmdfile}` as expected" do
        command = cmdfile.read.strip
        argv    = Quickl.parse_commandline_args(command)[1..-1]
        stdout  = cmdfile.sub_ext('.stdout').read

        out, err = capture_io do
          begin
            Dir.chdir(fixtures_dir){ Command.run(argv) }
          rescue SystemExit
            puts "SystemExit"
          end
        end

        out.should eq stdout
      end

    end

  end
end