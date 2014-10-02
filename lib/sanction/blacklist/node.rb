module Sanction
  module Blacklist
    class Node < Sanction::Node

      def permitted?
        return false if wildcarded? && @parent.blacklist?
        return true  if wildcarded? && @parent.whitelist?
        root? ? true : (@parent[type].permitted? && @parent[type].allowed_ids.include?(id))
      end

      def whitelist?
        false
      end

      def blacklist?
        true
      end

      def mode
        'blacklist'
      end

      def array_class
        Sanction::Blacklist::Array
      end

      def null_array_class
        Sanction::Blacklist::NullArray
      end

    end
  end
end