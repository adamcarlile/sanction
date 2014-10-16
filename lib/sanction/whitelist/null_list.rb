module Sanction
  module Whitelist
    class NullList < Sanction::Whitelist::List

      def permitted?
        return true  if wildcard_resource?
        return true  if resources.include?(@key) && !ids_blank?
        return false if ids_blank?
      end

      def persisted?
        false
      end

      def null_node_class
        Sanction::Whitelist::NullNode
      end

    end
  end
end