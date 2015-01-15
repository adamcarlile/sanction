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

      def scope
        permitted? ? super : []
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
        Sanction::Whitelist::List
      end

      def null_array_class
        Sanction::Whitelist::NullList
      end

    end
  end
end