require_relative "gisele/version"
require_relative "gisele/loader"
#
# Gisele is a Process Analyzer Toolset
#
module Gisele

  def parse(input)
    Language::Parser::parse(input)
  end
  module_function :parse

end # module Gisele
require_relative 'gisele/language'