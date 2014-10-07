module Sanction
  module Blacklist
    class NullNode < Sanction::Blacklist::Node

      def permitted?
        a = ancestors.reject(&:root?).map(&:permitted?)
        a << true 
        a.all?
      end

      def allow!
        false
      end

      def deny!
        ancestors.reject(&:persisted?).each(&:deny!)
        @parent.resources << type
        @parent.resources.uniq!
        @parent.add_subject({
          id:   id,
          type: type
        })
      end

      def persisted?
        false
      end

      def array_class
        Sanction::Blacklist::NullArray
      end

      alias :null_array_class :array_class

    end
  end
end