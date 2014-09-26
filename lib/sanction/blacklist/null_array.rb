module Sanction
  module Blacklist
    class NullArray < Sanction::Blacklist::Array

      def permitted?
        @parent.permitted?
      end

      def null_node_class
        Sanction::Blacklist::NullNode
      end

    end
  end
end