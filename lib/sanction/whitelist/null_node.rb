module Sanction
  module Whitelist
    class NullNode < Sanction::Blacklist::Node

      def permitted?
        true
      end

      def whitelist?
        false
      end

      def blacklist?
        true
      end

      def array_class
        Sanction::Blacklist::NullArray
      end

    end
  end
end