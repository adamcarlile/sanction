module Sanction
  module Whitelist
    class Node < Sanction::Node

      def permitted?
        root? ? true : @parent.children.permitted?
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