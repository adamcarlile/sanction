module Sanction
  # A graph built from other graphs combined with a boolean operator. It owns
  # no nodes of its own; it evaluates each member against the same predicates
  # and folds the results — :all for intersection (AND), :any for union (OR).
  #
  # Sanction::Permission detects a composite and delegates to it instead of
  # walking a node path, so a composite drops into any call site that accepts a
  # graph: Sanction::Permission.new(org.and(role).or(admin), track).permitted?
  class Composite
    include Sanction::Composable

    def initialize(operator, *members)
      @operator = operator
      @members  = members
    end

    def composite?
      true
    end

    def permitted?(predicates)
      combine { |member| Sanction::Permission.new(member, *predicates).permitted? }
    end

    def permitted_with_scope?(scope, predicates)
      combine { |member| Sanction::Permission.new(member, *predicates).permitted_with_scope?(scope) }
    end

    private

    def combine(&block)
      results = @members.map(&block)
      @operator == :all ? results.all? : results.any?
    end
  end
end
