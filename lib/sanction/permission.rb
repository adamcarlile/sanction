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
      end.reject { |x| x[:node].blank? }
    end

    def permitted_path
      @permitted_path ||= path.map {|x| x[:node].parent.permitted?(x[:predicate].class.to_s.demodulize.underscore.to_sym, x[:predicate].id) }
    end

    def permitted?
      permitted_path.all?
    end

    def permitted_with_scope?(scope)
      permitted? && path.last[:node].has_scope?(scope)
    end

  end
end