module Gisele
  module Compiling
    class ToGraph < Sexpr::Rewriter
      grammar Language

      # We do not support the elsif syntactic sugar here; rewrite it as 'else if'.
      use Language::ElsifFlattener

      # This is a marker for the graph nodes we can remove later.
      module Connector; end

      def on_unit_def(sexpr)
        sexpr.
          sexpr_body.
          select{|n| n.first == :task_def}.
          map{|taskdef| apply(taskdef) }
      end

      def on_task_def(sexpr)
        @graph = Yargi::Digraph.new

        entry, exit = add_vertex(sexpr), add_vertex(sexpr)
        c_entry, c_exit = apply(sexpr.last)
        connect(entry, c_entry)
        connect(c_exit, exit)

        @graph.vertices(Connector).each do |vertex|
          next unless vertex.out_edges.size == 1
          target = vertex.out_edges.first.target
          @graph.reconnect(vertex.in_edges, nil, target)
          @graph.remove_vertex(vertex)
        end

        @graph
      end

      def on_seq_st(sexpr)
        mine    = entry_and_exit(sexpr)
        current = mine.first
        sexpr.sexpr_body.each do |child|
          c_entry, c_exit = apply(child)
          connect(current, c_entry)
          current = c_exit
        end
        connect(current, mine.last)
        mine
      end

      def on_par_st(sexpr)
        entry, exit = add_vertex(sexpr), add_vertex(sexpr)
        sexpr.sexpr_body.each do |child|
          c_entry, c_exit = apply(child)
          connect(entry, c_entry)
          connect(c_exit, exit)
        end
        [entry, exit]
      end

      def on_if_st(sexpr)
        cond, then_clause, else_clause, = sexpr.sexpr_body

        entry, exit = entry_and_exit(sexpr)

        diamond = add_vertex(sexpr)
        connect(entry, diamond)

        c_entry, c_exit = apply(then_clause)
        connect(diamond, c_entry, true_ast_sexpr)
        connect(c_exit, exit)

        if else_clause
          c_entry, c_exit = apply(else_clause.last)
          connect(diamond, c_entry, false_ast_sexpr)
          connect(c_exit, exit)
        else
          connect(diamond, exit, false_ast_sexpr)
        end

        [entry, exit]
      end

      def on_case_st(sexpr)
        cond, *clauses = sexpr.sexpr_body

        entry, exit = entry_and_exit(sexpr)

        diamond = add_vertex(sexpr)
        connect(entry, diamond)

        clauses.each do |clause|
          c_entry, c_exit = apply(clause.last)
          connect(diamond, c_entry, clause)
          connect(c_exit, exit)
        end

        [entry, exit]
      end


      def on_while_st(sexpr)
        cond, dost, = sexpr.sexpr_body

        entry, exit = entry_and_exit(sexpr)

        diamond = add_vertex(sexpr)
        connect(entry, diamond)

        c_entry, c_exit = apply(sexpr.last)

        connect(diamond, exit,    false_ast_sexpr)
        connect(diamond, c_entry, true_ast_sexpr)
        connect(c_exit, diamond)

        [entry, exit]
      end

      def on_task_call_st(sexpr)
        entry, exit = entry_and_exit(sexpr)
        task = add_vertex(sexpr)
        connect(entry, task)
        connect(task, exit)
        [entry, exit]
      end

      private

      def add_vertex(sexpr)
        @graph.add_vertex(dot_attributes(sexpr))
      end

      def entry_and_exit(sexpr, tag = Connector)
        @graph.add_n_vertices(2, tag)
      end

      def connect(source, target, sexpr = nil)
        @graph.connect(source, target, dot_attributes(sexpr))
      end

      def false_ast_sexpr
        sexpr(parse("false", :root => :bool_expr))
      end

      def true_ast_sexpr
        sexpr(parse("true", :root => :bool_expr))
      end

      DOT_ATTRIBUTES = YAML.load_file(Path.dir/"to_graph.yml")
      def dot_attributes(sexpr)
        if Sexpr===sexpr
          attrs = DOT_ATTRIBUTES["graphviz"][sexpr.first.to_s] || {}
          attrs = attrs.merge(:label => sexpr.label) if sexpr.respond_to?(:label)
          attrs
        else
          {} # sometimes, sexpr is simply nil
        end
      end

    end # class ToGraph
  end # module Compiling
end # module Gisele