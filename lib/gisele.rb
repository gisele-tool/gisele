require_relative "gisele/version"
require_relative "gisele/loader"
#
# Gisele is a Process Analyzer Toolset
#
module Gisele

  def parse(input)
    Language::Syntax::parse(input)
  end
  module_function :parse

  def ast(input)
    Language::Syntax::ast(input)
  end
  module_function :ast

end # module Gisele
require_relative 'gisele/language'