module Sanction
  module Blacklist
    class List < Sanction::AttachedList

      def allowed_ids
        []
      end

      def permitted?
        return false if wildcard_resource?
        return false if resources.include?(@key)
        return true if ids_blank?
        true
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