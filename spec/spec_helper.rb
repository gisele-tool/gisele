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

module SpecHelpers
  include Gisele::Language::AST::Helpers

  def parse(text, rule, consume = true)
    grammar = Gisele::Language::Syntax::Grammar
    grammar.parse(text, :root => rule, :consume => consume)
  end

  def ast(text, rule, consume = true)
    ast = parse(text, rule, consume).to_ast
    unless Gisele::Language::SEXP_GRAMMAR[rule] === ast
      raise "expected #{ast} to match #{rule} (#{text})"
    end
    ast
  end

  def fixtures_dir
    (Path.dir/:fixtures)
  end

  def fixture_files(glob)
    fixtures_dir.glob(glob)
  end

  def simple_ast
    Gisele::ast(fixtures_dir/:tasks/"simple.gis")
  end

  def complete_ast
    Gisele::ast(fixtures_dir/:tasks/"complete.gis")
  end

end

RSpec.configure do |c|
  c.extend  SpecHelpers
  c.include SpecHelpers
end