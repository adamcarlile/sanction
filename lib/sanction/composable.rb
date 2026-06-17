module Sanction
  # Boolean composition for permission graphs. Mixed into every graph (the
  # whitelist/blacklist nodes) and into Composite itself, so graphs and the
  # composites they produce combine uniformly and nest to any depth.
  #
  # Chaining is left-associative with no AND-over-OR precedence:
  #   a.and(b).or(c)  ==  (a AND b) OR c
  # For explicit grouping, nest a chain as the argument:
  #   a.or(b.and(c))  ==  a OR (b AND c)
  module Composable
    def and(other)
      Sanction::Composite.new(:all, self, other)
    end

    def or(other)
      Sanction::Composite.new(:any, self, other)
    end
  end
end
