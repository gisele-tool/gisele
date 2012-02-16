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

  def fixture_files(glob)
    (Path.dir/:fixtures).glob(glob)
  end

end

RSpec.configure do |c|
  c.extend Helpers
end