module Sanction
  class SearchableArray
    class Whitelist < SearchableArray

      def allowed_ids
        entries.map {|x| x.id}
      end

      def blacklist?
        false
      end

      def type
        entries.map {|x| x.type}.uniq.first
      end

      def whitelist?
        true
      end

      def denied_ids
        []
      end

    end
  end
end