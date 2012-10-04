require 'gisele'
module Gisele
  #
  # Gisele - A Process Analyzer Toolset
  #
  # SYNOPSIS
  #   gisele [--version] [--help]
  #   gisele [--ast | --graph] PROCESS_FILE
  #
  # OPTIONS
  # #{summarized_options}
  #
  # DESCRIPTION
  #   The Gisele process analyzer toolset provides tools and technique to model and analyze
  #   complex process models such as care processes.
  #
  #   When --no-sugar is specified, syntactic sugar is first removed before making any other
  #   transformation. For now, this rewrites all `if` statements as explicit `case` guarded
  #   commands.
  #
  #   When --ast is used, the command parses the process file and prints its Abstract Syntax
  #   Tree (AST) on standard output. By default, this option prints the AST for manual
  #   debugging, that is with colors and extra information. Use --ast=ruby to get a ruby
  #   array for automatic processing.
  #
  #   When --graph is used, the command parses the process file. It then converts the AST into
  #   a directed graph representing the process as a box-and-arrow workflow and outputs it on
  #   standard output. For now, the only output format available is dot (from graphviz).
  #
  class Gisele::Command <  Quickl::Command(__FILE__, __LINE__)

    # Install options
    options do |opt|
      @sugar = true
      opt.on('--no-sugar', 'Apply syntactic sugar removal') do
        @sugar = false
      end

      @compile_mode = [:ast, "debug"]
      opt.on('--ast=[MODE]',
             'Compile as an abstract syntax tree (debug,ruby)') do |value|
        @compile_mode = [:ast, (value || "debug").to_sym]
      end
      opt.on('--graph=[MODE]',
             'Compile as a workflow graph (dot)') do |value|
        @compile_mode = [:graph, (value || "dot").to_sym]
      end
      opt.on('--glts=[MODE]',
             'Compile as guarded labeled transition system (dot)') do |value|
        @compile_mode = [:glts, (value || "dot").to_sym]
      end

      opt.on('-d', '--deterministic',
             'Determinize gtls output?') do
        @determinize = true
      end
      opt.on('-e', '--explicit',
             'Explicit guards in gtls output?') do
        @explicit = true
      end
      opt.on('-s', '--separate',
             'Split guards from events in glts output?') do
        @separate = true
      end

      opt.on_tail('--help', "Show this help message") do
        raise Quickl::Help
      end
      opt.on_tail('--version', 'Show version and exit') do
        raise Quickl::Exit, "gisele #{Gisele::VERSION} (c) The University of Louvain"
      end
    end

    def execute(args)
      raise Quickl::Help unless args.size == 1

      unless (file = Path(args.first)).exist?
        raise Quickl::IOAccessError, "File does not exists: #{file}"
      end

      ast = Gisele.ast(file)
      ast = Language::SugarRemoval.call(ast) unless @sugar

      send :"compile_#{@compile_mode.first}", ast, *@compile_mode[1..-1]
    end

    private

    def compile_ast(ast, option)
      require 'awesome_print'
      options = {}
      options = {index: false, plain: true} if option == :ruby
      ap ast, options
    end

    def compile_graph(ast, option)
      graph = Analysis::Compiling::Ast2Graph.call(ast)
      puts graph.to_dot
    end

    def compile_glts(ast, mode)
      session = Analysis::Compiling::Ast2Session.call(ast)
      glts    = Analysis::Compiling::Ast2Glts.call(session, ast)
      glts    = glts.determinize if @determinize
      glts    = glts.separate    if @separate
      glts    = glts.explicit_guards! if @explicit
      case mode
      when :dot      then puts glts.to_dot
      when :ruby     then puts glts.to_ruby_literal
      when :relation then puts glts.to_relation.to_ruby_literal
      when :text     then puts glts.to_relation.to_text
      when :rash     then puts glts.to_relation.to_rash
      else
        raise "Unrecognized --glts output mode `mode`"
      end
    ensure
      session.close if session
    end

end # class Command
end # module Gisele