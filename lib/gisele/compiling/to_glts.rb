module Gisele
  module Compiling
    class ToGlts < Sexpr::Rewriter
      grammar Language

      DOT_REWRITER = lambda{|elm,kind|
        case kind
          when :automaton
            {:rankdir => "LR"}
          when :state
            {:shape => "circle",
             :style => "filled",
             :color => "black",
             :fillcolor => (elm.initial? ? "green" : "white")}
          when :edge
            label = elm[:guard] ? "[#{elm[:guard].label}]" : elm[:symbol]
            {:label => label || ''}
        end
      }

      # if/elsif/else -> guarded commands
      use Language::IfToCase

      def on_unit_def(sexpr)
        sexpr.
          sexpr_body.
          select{|n| n.first == :task_def}.
          map{|taskdef| apply(taskdef) }
      end

      def on_task_def(sexpr)
        @glts = Stamina::Automaton.new

        entry = add_state(sexpr, :initial => true)
        exit  = add_state(sexpr)
        c_entry, c_exit = apply(sexpr.last)
        connect(entry, c_entry)
        connect(c_exit, exit)

        @glts
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
      alias :on_par_st :on_seq_st

      def on_case_st(sexpr)
        cond, *clauses = sexpr.sexpr_body

        entry, exit = entry_and_exit(sexpr)

        diamond = add_state(sexpr)
        connect(entry, diamond)

        clauses.each do |clause|
          c_entry, c_exit = apply(clause.last)
          connect(diamond, c_entry, clause[1])
          connect(c_exit, exit)
        end

        [entry, exit]
      end

      def on_while_st(sexpr)
        cond, dost, = sexpr.sexpr_body

        entry, exit = entry_and_exit(sexpr)

        diamond = add_state(sexpr)
        connect(entry, diamond)

        c_entry, c_exit = apply(sexpr.last)

        connect(diamond, exit, cond.negate)
        connect(diamond, c_entry, cond)
        connect(c_exit, diamond)

        [entry, exit]
      end

      def on_task_call_st(sexpr)
        entry, exit = entry_and_exit(sexpr)
        middle = add_state(sexpr)
        connect(entry, middle, transition(sexpr, "start"))
        connect(middle, exit, transition(sexpr, "end"))
        [entry, exit]
      end

      private

      def entry_and_exit(sexpr)
        @glts.add_n_states(2)
      end

      def add_state(sexpr, attrs = nil)
        @glts.add_state(attrs || {})
      end

      def connect(source, target, attrs = {:symbol => nil})
        attrs = transition(attrs) unless Hash===attrs
        @glts.connect(source, target, attrs)
      end

      def transition(sexpr, kind = nil)
        raise UnexpectedNodeError, "Node expected, got #{sexpr}" unless Sexpr===sexpr
        case sexpr.first
        when :task_call_st then {:symbol => "#{sexpr.label}:#{kind}"}
        when :bool_expr    then {:symbol => "[guard]", :guard => sexpr}
        else
          raise UnexpectedNodeError, "Unexpected event kind #{sexpr.inspect}"
        end
      end

    end # class ToGlts
  end # module Compiling
end # module Gisele