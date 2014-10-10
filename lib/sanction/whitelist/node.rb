module Sanction
  module Whitelist
    class Node < Sanction::Node

      def permitted?
        super
        root? ? true : (@parent[type].permitted? && @parent[type].allowed_ids.include?(id))
      end

      def allow!
        false
      end

      def deny!
        @parent.resources << type
        @parent.resources.uniq!
        unlink
        true
      end

      def whitelist?
        true
      end

      def blacklist?
        false
      end

      def mode
        'whitelist'
      end

      def array_class
        Sanction::Whitelist::Array
      end

      def null_array_class
        Sanction::Whitelist::NullArray
      end

    end
  end
end