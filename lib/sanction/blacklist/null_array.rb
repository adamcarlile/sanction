module Sanction
  module Blacklist
    class NullArray < Sanction::Blacklist::Array

      def permitted?
        return false if wildcard_resource?
        return false if resources.include?(@key) && ids_blank?
        return true if ids_blank?
      end

      def persisted?
        false
      end

      def null_node_class
        Sanction::Blacklist::NullNode
      end

    end
  end
end