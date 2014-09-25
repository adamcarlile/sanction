module Sanction
  module Blacklist
    class NullNode < Sanction::Blacklist::Node

      def array_class
        Sanction::Blacklist::NullArray
      end

    end
  end
end