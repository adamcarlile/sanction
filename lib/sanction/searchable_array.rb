module Sanction
  class SearchableArray < Array

    attr_accessor :key, :parent

    def [](index)
      if entries.detect {|x| x.id == index}
        entries.detect {|x| x.id == index}
      else
        null_node_class.new({id: index, type: key, scope: []}, @parent)
      end
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