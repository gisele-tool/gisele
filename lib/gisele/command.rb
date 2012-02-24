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
      @print_ast = nil
      opt.on('--ast=[MODE]', 'Prints the process abstract syntax tree (debug,ruby)') do |value|
        @print_ast = (value || "debug").to_sym
      end
      @sugar = true
      opt.on('--no-sugar', 'Apply syntactic sugar removal') do
        @sugar = false
      end
      @print_graph = nil
      opt.on('--graph=[MODE]', 'Converts and print a graph (dot)') do |value|
        @print_graph = (value || "dot").to_sym
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
      ast = Language::SugarRemoval.new.call(ast) unless @sugar

      print_ast(ast, @print_ast) if @print_ast
      print_graph(ast, @print_graph) if @print_graph
    end

    private

    def print_ast(ast, option)
      require 'awesome_print'
      options = case option
                when :ruby then {index: false, plain: true}
                else
                  {}
                end
      ap ast, options
    end

    def print_graph(ast, option)
      graphs = Gisele::Language::ToGraph.new.call(ast)
      graphs.each do |graph|
        puts graph.to_dot
      end
    end

end # class Command
end # module Gisele