module Sanction
  class SearchableArray
    class Blacklist < SearchableArray

      def allowed_ids
        []
      end

      def type
        entries.map {|x| x.type}.uniq.first
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

    end
  end
end