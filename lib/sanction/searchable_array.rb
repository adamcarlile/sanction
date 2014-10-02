module Sanction
  class SearchableArray < Array

    attr_accessor :key, :parent

    def [](index)
      entries.detect {|x| x.id == index} || wildcard_member || null_node_class.new({id: index, type: key, scope: []}, @parent)
    end

    def type
      key
    end

    def has_scope? scope
      @parent.has_scope? scope
    end

    def wildcard_member
      entries.detect {|x| x.wildcarded? }
    end

    def wildcard_resource?
      resources.include?(:*)
    end

    def resources
      @parent.resources
    end

    private

      def null_node_class
        raise NotImplementedError
      end

  end
end