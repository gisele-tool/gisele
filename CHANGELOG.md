# 0.1.0 / FIX ME

## Enhancements

* The main `gisele` command now accepts a --no-sugar option that removes syntactic
  sugar. This option is limited to the rewriting of `if` statements as guarded `case`
  commands for now. Additional rewriting could be added in the future.
* All AST nodes (obtained via `Gisele.ast` or similar) now include the module 
  `Gisele::Language::AST::Node` which contains a few utilities.

## Breaking changes

* The language package has been reorganized and is now considered as belonging to
  the private API. Further changes there will therefore not b considered as Breaking
  changes in the future (expect the structure of the AST, of course). 
  The `Gisele.parse` and `Gisele.ast` methods belong to the public API and are therefore
  the way to (parse / get an AST) from a process file / source.

* The top AST element of a process file is always a :unit. The latter may contain 
  one ore more task definitions. Import/include nodes will probably be added later
  and authorized at the beginning of the file.

* The following syntax nodes have been renamed:
    :varref     -> :var_ref
    :or         -> :bool_or
    :and        -> :bool_and
    :not        -> :bool_not
    :if         -> :if_st
    :else       -> :else_clause
    :elsif      -> :elsif_clause
    :while      -> :while_st
    :seq        -> :seq_st
    :par        -> :par_st
    :task_call  -> :task_call_st
    :task       -> :task_def
    :signature  -> :task_signature
    :refinement -> :task_refinement

# 0.0.1 / 2012-02-16

* Enhancements

  * Birthday!
