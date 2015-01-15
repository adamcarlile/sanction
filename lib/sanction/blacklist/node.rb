module Sanction
  module Blacklist
    class Node < Sanction::Node

      def permitted?
        super
        root? ? true : (@parent[type].permitted? && @parent[type].allowed_ids.include?(id))
      end

      def allow!
        @parent.resources.reject! {|x| x == type } unless @parent[type].count > 1
        unlink
        true
      end

      def scope
        permitted? ? super : []
      end

      def deny!
        false
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
        Sanction::Blacklist::List
      end

      def null_array_class
        Sanction::Blacklist::NullList
      end

    end
  end
end