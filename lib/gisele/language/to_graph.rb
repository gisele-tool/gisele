module Gisele
  module Language
    class ToGraph < Transformer
      module Connector; end

      def recurse_on_last(node)
        call(node.last)
      end
      alias :on_unit            :recurse_on_last
      alias :on_task_refinement :recurse_on_last

      def on_task_def(node)
        @graph = Yargi::Digraph.new
        call(SugarRemoval.new.call(node.last))
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
        entry, exit = entry_and_exit(node)
        node.children.each do |child|
          c_entry, c_exit = call(child)
          connect(entry, c_entry)
          connect(exit,  c_exit)
        end
        [entry, exit]
      end

      def on_case_st(node)
        entry, exit = entry_and_exit(node)

        diamond = add_vertex(node)
        connect(entry, diamond)

        node.children.each do |when_clause|
          c_entry, c_exit = call(when_clause.last)
          connect(diamond, c_entry, when_clause)
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

      def entry_and_exit(node)
        @graph.add_n_vertices(2, Connector)
      end

      def connect(source, target, node = nil)
        marks = node.nil? ? {} : node.dot_attributes
        @graph.connect(source, target, marks)
      end

      def false_ast_node
        node([:bool_expr, [:bool_lit, false]])
      end

      def true_ast_node
        node([:bool_expr, [:bool_lit, true]])
      end

    end # class SugarRemoval
  end # module Language
end # module Gisele
