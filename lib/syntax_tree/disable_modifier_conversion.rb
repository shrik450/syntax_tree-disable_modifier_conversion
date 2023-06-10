# frozen_string_literal: true

module SyntaxTree
  class ConditionalFormatter
    def format(q)
      if node.modifier?
        statement = node.statements.body[0]

        if ContainsAssignment.call(statement) || q.parent.is_a?(In)
          q.group { format_flat(q) }
        else
          q.group do
            q
              .if_break { format_break(q, force: false) }
              .if_flat { format_flat(q) }
          end
        end
      else
        # If we can transform this node into a ternary, then we're going to
        # print a special version that uses the ternary operator if it fits on
        # one line.
        if Ternaryable.call(q, node)
          format_ternary(q)
          return
        end

        # If the predicate of the conditional contains an assignment (in which
        # case we can't know for certain that that assignment doesn't impact the
        # statements inside the conditional) then we can't use the modifier form
        # and we must use the block form.
        if ContainsAssignment.call(node.predicate)
          format_break(q, force: true)
          return
        end

        if node.consequent || node.statements.empty? || contains_conditional?
          q.group { format_break(q, force: true) }
        else
          q.group do
            q
              .if_break { format_break(q, force: false) }
              # --- THIS IS THE LINE THAT WAS CHANGED ---
              .if_flat { format_break(q, force: true) }
              # --- THIS IS THE LINE THAT WAS CHANGED ---
          end
        end
      end
    end
  end
end
