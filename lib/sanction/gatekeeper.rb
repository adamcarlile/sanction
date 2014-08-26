module Sanction
  class Gatekeeper

    def initialize(permissions, *predicates)
      @permissions_graph = permissions
      @objects = []
      predicates.each do |object|
        add_object(object)
      end
    end

    def add_object(object)
      raise ArgumentError 'Missing ID attribute for object' unless object.respond_to? :id
      @objects << object
    end

    def path
      @path ||= objects.map { |object| @permissions_graph.find(object.class.to_s.demodulize.underscore.to_sym, object.id)}
    end

    def permission
      binding.pry
      path.compact.last if path.compact.last.permitted?
    end

    private

      attr_reader :objects

  end
end