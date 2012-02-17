$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gisele'
require 'epath'

def capture_io
  stdout, stderr = $stdout, $stderr
  $stdout, $stderr = StringIO.new, StringIO.new
  yield
  [$stdout.string, $stderr.string]
ensure
  $stdout, $stderr = stdout, stderr
end

module Helpers

  def fixtures_dir
    (Path.dir/:fixtures)
  end

  def fixture_files(glob)
    fixtures_dir.glob(glob)
  end

  def node(arr)
    Gisele::Language::AST::node(arr)
  end

end

RSpec.configure do |c|
  c.extend  Helpers
  c.include Helpers
end