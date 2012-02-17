module Gisele

  class Error < StandardError
    attr_reader :cause
    def initialize(msg, cause = $!)
      super(msg)
      @cause = cause
    end
  end

  # Internal errors certainly denote bugs in the implementation. 
  # They are typically raised when a precondition is violated.
  class InternalError < Error
  end

  # Raised when an unexpected node is encountered in an AST-driven
  # transformation.
  class UnexpectedNodeError < InternalError
  end

end # module Gisele