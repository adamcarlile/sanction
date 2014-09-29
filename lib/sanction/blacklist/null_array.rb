module Sanction
  module Blacklist
    class NullArray < Sanction::Blacklist::Array

      def permitted?
        return false if wildcard_resource?
        resources.include?(@key) ? false : true
      end

      def null_node_class
        Sanction::Blacklist::NullNode
      end

    end
  end
end