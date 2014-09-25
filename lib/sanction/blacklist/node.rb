module Sanction
  module Blacklist
    class Node < Sanction::Node

      def permitted?
        false        
      end

      def whitelist?
        false
      end

      def blacklist?
        true
      end

      def array_class
        Sanction::Blacklist::Array
      end

    end
  end
end