module Sanction
  module Whitelist
    class Node < Sanction::Node

      def permitted?
        true
      end

      def whitelist?
        true
      end

      def blacklist?
        false
      end

      def array_class
        Sanction::Whitelist::Array
      end

      def null_array_class
        Sanction::Whitelist::NullNode
      end

    end
  end
end