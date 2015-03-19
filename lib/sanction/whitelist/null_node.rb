module Sanction
  module Whitelist
    class NullNode < Sanction::Whitelist::Node

      def permitted?
        a = ancestors.reject(&:root?).map(&:permitted?)
        a << false 
        a.all?
      end

      def allow!
        ancestors.reject(&:persisted?).each(&:allow!)
        @parent = root.find(@parent.type, @parent.id) unless @parent.persisted?
        @parent.resources << type
        @parent.resources.uniq!
        @parent.add_subject({
          id:   id,
          type: type
        })
      end

      def deny!
        false
      end

      def persisted?
        false
      end

      def array_class
        Sanction::Whitelist::NullList
      end

      alias :null_array_class :array_class

    end
  end
end