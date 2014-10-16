module Sanction
  class AttachedList < SimpleDelegator

    attr_accessor :key, :parent

    def initialize(array = [])
      super(array)
    end

    def [](index)
      detect {|x| x.id == index} || wildcard_member || null_node_class.new({id: index, type: key, scope: []}, @parent)
    end

    def type
      key
    end

    def ids_blank?
      denied_ids.blank? && allowed_ids.blank?
    end

    def denied_ids
      []
    end

    def allowed_ids
      []
    end

    def has_scope? scope
      @parent.has_scope? scope
    end

    def wildcard_member
      detect {|x| x.wildcarded? }
    end

    def wildcarded?
      !!wildcard_member
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