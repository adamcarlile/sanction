module Sanction
  module Whitelist
    class NullNode < Sanction::Blacklist::Node

      def permitted?
        a = ancestors.map(&:permitted?)
        a << false 
        a.all?
      end

      def array_class
        Sanction::Whitelist::NullArray
      end

      alias :null_array_class :array_class

    end
  end
end