$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gisele'
require 'epath'

module Helpers

  def fixture_files(glob)
    (Path.dir/:fixtures).glob(glob)
  end

end

RSpec.configure do |c|
  c.extend Helpers
end