module Sanction
  module Blacklist
    class Node < Sanction::Node

      def permitted?
        root? ? false : @parent.children.permitted?
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