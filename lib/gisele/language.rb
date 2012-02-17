module Gisele
  module Language

    def rule2mod(rule)
      rule.to_s.gsub(/(^|_)([a-z])/){|x| $2.capitalize}.to_sym
    end
    module_function :rule2mod

    def mod2rule(mod)
      mod = mod.name.to_s.split('::').last.to_sym if mod.is_a?(Module)
      mod.to_s.gsub(/[A-Z]/){|x| "_#{x.downcase}"}[1..-1].to_sym
    end
    module_function :mod2rule

  end # module Language
end # module Gisele
require_relative 'language/syntax'
require_relative 'language/ast'
require_relative 'language/transformer'
require_relative 'language/sugar_removal'
require_relative 'language/to_graph'