module Sanction
  module Whitelist
    class NullArray < Sanction::Whitelist::Array

      def permitted?
        return true if wildcard_resource?
        resources.include?(@key) ? true : false
      end

      def null_node_class
        Sanction::Whitelist::NullNode
      end

    end
  end
end