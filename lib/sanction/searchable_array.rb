module Sanction
  class SearchableArray < Array

    attr_accessor :key, :parent

    def [](index)
      entries.detect {|x| x.id == index} || null_node_class.new({id: index, type: key, scope: []}, @parent)
    end

    def type
      key
    end

    private

      def null_node_class
        raise NotImplementedError
      end

  end
end