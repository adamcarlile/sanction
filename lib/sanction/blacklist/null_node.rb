module Sanction
  module Blacklist
    class NullNode < Sanction::Blacklist::Node

      def permitted?
        a = ancestors.map(&:permitted?)
        a << true 
        a.all?
      end

      def array_class
        Sanction::Blacklist::NullArray
      end

      alias :null_array_class :array_class

    end
  end
end