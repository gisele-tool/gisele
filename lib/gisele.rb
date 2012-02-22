require_relative "gisele/version"
require_relative "gisele/loader"
require_relative 'gisele/errors'
#
# Gisele is a Process Analyzer Toolset
#
module Gisele

  def parse(*args)
    Language::parse(*args)
  end

  def ast(*args)
    Language::sexpr(*args)
  end

  extend(self)
end # module Gisele
require_relative 'gisele/language'