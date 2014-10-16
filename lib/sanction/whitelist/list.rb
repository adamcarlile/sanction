module Sanction
  module Whitelist
    class List < Sanction::AttachedList

      def allowed_ids
        (wildcard_resource? || resources.include?(@key)) ? entries.map {|x| x.id} : []
      end

      def permitted?
        return true  if wildcard_resource?
        return false if ids_blank?
        return true  if resources.include?(@key)
        false
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