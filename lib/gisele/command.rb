require 'gisele'
module Gisele
  #
  # Gisele - A Process Analyzer Toolset
  #
  # SYNOPSIS
  #   gisele [--version] [--help]
  #   gisele [--ast] PROCESS_FILE
  #
  # OPTIONS
  # #{summarized_options}
  #
  # DESCRIPTION
  #   The Gisele process analyzer toolset provides tools and technique to model and analyze
  #   complex process models such as care processes.
  #
  #   When --ast is used, the command parses a process file and prints its Abstract Syntax
  #   Tree (AST) on standard output. By default, this option prints the AST for manual
  #   debugging, that is with colors and extra information. Use --ast=ruby to get a ruby
  #   array for automatic processing.
  #
  class Gisele::Command <  Quickl::Command(__FILE__, __LINE__)

    # Install options
    options do |opt|
      @ast = nil
      opt.on('--ast=[MODE]', 'Prints the process abstract syntax tree (debug,ruby)') do |value|
        @ast = (value || "debug").to_sym
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

      parsed = Gisele::Language::Parser.parse(file)
      print_ast(parsed, @ast) if @ast
    end

    private

    def print_ast(ast, option)
      require 'awesome_print'
      options = case option
                when :ruby
                  {index: false, plain: true}
                else
                  {}
                end
      ap ast, options
    end

  end # class Command
end # module Gisele