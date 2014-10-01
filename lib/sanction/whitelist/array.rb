module Sanction
  module Whitelist
    class Array < Sanction::SearchableArray

      def allowed_ids
        permitted? ? entries.map {|x| x.id} : []
      end

      def permitted?
        return true if wildcard_resource?
        resources.include?(@key) ? true : false
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
        Sanction::Whitelist::NullNode
      end

    end
  end
end