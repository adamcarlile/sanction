module Sanction
  module Whitelist
    class NullArray < Sanction::Blacklist::Array

      def permitted?
        false
      end

      def null_node_class
        Sanction::Whitelist::NullNode
      end

    end
  end
end