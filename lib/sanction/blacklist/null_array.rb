module Sanction
  module Blacklist
    class NullArray < Sanction::Blacklist::Array

      def null_node_class
        Sanction::Blacklist::NullNode
      end

    end
  end
end