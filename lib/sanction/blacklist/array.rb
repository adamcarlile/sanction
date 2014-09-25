module Sanction
  module Blacklist
    class Array < Sanction::SearchableArray

      def allowed_ids
        []
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
        Sanction::Blacklist::Node
      end

    end
  end
end