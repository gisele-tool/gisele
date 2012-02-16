require 'gisele'
module Gisele
  #
  # Gisele - A Process Analyzer Toolset
  #
  # SYNOPSIS
  #   gisele [--version] [--help] [--output=...] COMMAND [cmd opts] ARGS...
  #
  # OPTIONS
  # #{summarized_options}
  #
  # COMMANDS
  # #{summarized_subcommands}
  #
  # DESCRIPTION
  #   The Gisele process analyzer toolset provides tools and technique to model and analyze
  #   complex process models such as care processes.
  #
  # See 'gisele help COMMAND' for more information on a specific command.
  #
  class Gisele::Command <  Quickl::Delegator(__FILE__, __LINE__)

    # Install options
    options do |opt|
      opt.on_tail('--help', "Show this help message"){ 
        raise Quickl::Help 
      }
      opt.on_tail('--version', 'Show version and exit'){
        raise Quickl::Exit, "gisele #{Gisele::VERSION} (c) The University of Louvain"
      }
    end
  
  end # class Command
end # module Gisele