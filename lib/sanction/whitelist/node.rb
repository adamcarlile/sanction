module Sanction
  module Whitelist
    class Node < Sanction::Node

      def permitted?(type, id)
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

    end
  end
end