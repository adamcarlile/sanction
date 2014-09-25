module Sanction
  module Whitelist
    class Array < Sanction::SearchableArray

      def allowed_ids
        entries.map {|x| x.id}
      end

      def blacklist?
        false
      end

      def whitelist?
        true
      end

      def denied_ids
        []
      end

      def null_node_class
        Sanction::Blacklist::Node
      end

    end
  end
end