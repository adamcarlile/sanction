module Sanction
  module Blacklist
    class Array < Sanction::SearchableArray

      def allowed_ids
        []
      end

      def permitted?
        false
      end

      def blacklist?
        true
      end

      def whitelist?
        false
      end

      def denied_ids
        entries.map {|x| x.id}
      end

      def null_node_class
        Sanction::Blacklist::NullNode
      end

    end
  end
end