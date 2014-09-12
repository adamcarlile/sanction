module Sanction
  class Permission

    attr_reader :predicates

    def initialize(permission_graph, *predicates)
      @graph      = permission_graph
      @predicates = predicates
    end

    def path
      @path ||= predicates.map do |object|
        {
          predicate:  object,
          node:       @graph.find(object.class.to_s.demodulize.underscore.to_sym, object.id)
        }
      end.reject { |x| x[:node].root? }
    end

    def permitted_path
      @permitted_path ||= path.map do |x| 
        node = x[:node].root? ? x[:node] : x[:node].parent 
        node.permitted?(x[:predicate].class.to_s.demodulize.underscore.to_sym, x[:predicate].id)
      end
    end

    def permitted?
      return false if permitted_path.blank?
      permitted_path.all?
    end

    def permitted_with_scope?(scope)
      permitted? && path.last[:node].has_scope?(scope)
    end

  end
end