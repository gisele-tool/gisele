module Gisele
  module Language
    class ToGraph < Rewriter
      module Connector; end

      def recurse_on_last(node)
        call(node.last)
      end
      alias :on_unit_def :recurse_on_last

      def on_task_def(node)
        @graph = Yargi::Digraph.new

        entry, exit = add_vertex(node), add_vertex(node)

        # flatten all elsif
        c_entry, c_exit = call(ElsifFlattener.new.call(node.last))
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

      def on_seq_st(node)
        mine    = entry_and_exit(node)
        current = mine.first
        node.children.each do |child|
          c_entry, c_exit = call(child)
          connect(current, c_entry)
          current = c_exit
        end
        connect(current, mine.last)
        mine
      end

      def on_par_st(node)
        entry, exit = add_vertex(node), add_vertex(node)
        node.children.each do |child|
          c_entry, c_exit = call(child)
          connect(entry, c_entry)
          connect(c_exit, exit)
        end
        [entry, exit]
      end

      def on_if_st(node)
        cond, then_clause, else_clause, = node.children

        entry, exit = entry_and_exit(node)

        diamond = add_vertex(node)
        connect(entry, diamond)

        c_entry, c_exit = call(then_clause)
        connect(diamond, c_entry, true_ast_node)
        connect(c_exit, exit)

        if else_clause
          c_entry, c_exit = call(else_clause.last)
          connect(diamond, c_entry, false_ast_node)
          connect(c_exit, exit)
        else
          connect(diamond, exit, false_ast_node)
        end

        [entry, exit]
      end

      def on_case_st(node)
        cond, *clauses = node.children

        entry, exit = entry_and_exit(node)

        diamond = add_vertex(node)
        connect(entry, diamond)

        clauses.each do |clause|
          c_entry, c_exit = call(clause.last)
          connect(diamond, c_entry, clause)
          connect(c_exit, exit)
        end

        [entry, exit]
      end


      def on_while_st(node)
        cond, dost, = node.children

        entry, exit = entry_and_exit(node)

        diamond = add_vertex(node)
        connect(entry, diamond)

        c_entry, c_exit = call(node.last)

        connect(diamond, exit,    false_ast_node)
        connect(diamond, c_entry, true_ast_node)
        connect(c_exit, diamond)

        [entry, exit]
      end

      def on_task_call_st(node)
        entry, exit = entry_and_exit(node)
        task = add_vertex(node)
        connect(entry, task)
        connect(task, exit)
        [entry, exit]
      end

      private

      def add_vertex(node)
        @graph.add_vertex(node.dot_attributes)
      end

      def entry_and_exit(node, tag = Connector)
        @graph.add_n_vertices(2, tag)
      end

      def connect(source, target, node = nil)
        marks = node.nil? ? {} : node.dot_attributes
        @graph.connect(source, target, marks)
      end

      def false_ast_node
        Syntax.ast("false", :root => :bool_expr)
      end

      def true_ast_node
        Syntax.ast("true", :root => :bool_expr)
      end

    end # class SugarRemoval
  end # module Language
end # module Gisele
