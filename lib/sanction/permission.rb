module Sanction
  class Permission

    attr_reader :predicates

    def initialize(permission_graph, *predicates)
      @graph      = permission_graph
      @predicates = predicates
    end

    def path
      @path ||= begin
        path = @graph.root
        @predicates.each do |predicate|
          if predicate.is_a?(Class)
            path = path[predicate.to_s.demodulize.underscore.to_sym]
          else
            path = path[predicate.class.to_s.demodulize.underscore.to_sym][predicate.id]
          end
        end
        path
      end
    end

    def persisted?
      path.persisted?
    end

    def permitted?
      return @graph.permitted?(@predicates) if composite?
      path.permitted?
    end

    def permitted_with_scope?(scope)
      return @graph.permitted_with_scope?(scope, @predicates) if composite?
      permitted? && path.has_scope?(scope)
    end

    private

    def composite?
      @graph.respond_to?(:composite?) && @graph.composite?
    end

  end
end