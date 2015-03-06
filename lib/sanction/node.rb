module Sanction
  class Node
    include Tree

    attr_reader :id, :type

    def initialize(hash, parent=nil)
      @parent = parent
      process_hash(hash)
    end

    def permitted?
      return false if wildcarded? && @parent.blacklist?
      return true  if wildcarded? && @parent.whitelist?
    end

    def to_hash
      {
        id: @id,
        type: @type,
        mode: mode,
        scope: @scope,
        subjects: subjects.map {|x| x.to_hash},
        resources: @resources
      }.reject { |k, v| v.blank? }
    end

    def persisted?
      true
    end

    # Returns the new graph with the switched mode
    def change_type! type
      hash = to_hash
      klass = "sanction/#{type}/node".classify.constantize
      if root?
        klass.new(hash)
      else
        node = klass.new(hash, parent)
        parent.children << node
        unlink
        node.root
      end
    end

    def add_subject(hash)
      mode_class = hash[:mode] || mode
      children << "sanction/#{mode_class}/node".classify.constantize.new(hash, self)
    end

    # Virtual
    def array_class
      raise NotImplementedError
    end

    def null_array_class
      raise NotImplementedError
    end

    def [](key)
      klass = subjects.select {|x| x.type?(key) }.any? ? array_class : null_array_class
      klass.new(subjects.select {|x| x.type?(key) }).tap do |x| 
        x.key = key
        x.parent = self
      end
    end

    def find(type, id)
      out = root
      walk do |child|
        out = child if (child.type?(type) && child.id?(id))
      end
      out
    end

    def has_scope? scope_symbol
      scope.include? scope_symbol.to_sym
    end

    def type?(type)
      @type == type.to_sym
    end

    def id?(id)
      @id == id
    end

    def scope
      return @scope if (parent.blank? && root?)
      @scope.blank? ? parent.scope : @scope
    end

    def scope=(attribute)
      @scope = [attribute].flatten.compact.map(&:to_sym)
    end

    def add_scope(attribute)
      clone_scope! if @scope.blank?
      @scope << attribute.to_sym
      sanitize_scope!
    end

    def remove_scope(attribute)
      @scope.reject! {|x| x == attribute.to_sym }
    end

    def resources
      return [] if (@resources.blank? && root?)
      @resources.blank? ? parent.resources : @resources
    end

    def resources=(resource)
      @resources = [resource].flatten.compact.map(&:to_sym)
    end

    def mode
      raise NotImplementedError
    end

    def children?
      children.any?
    end

    def wildcarded?
      @id == '*'
    end

    def children
      @children ||= array_class.new
    end

    alias :subjects :children

    private

      def clone_scope!
        @scope = parent.scope.dup
      end

      def sanitize_scope!
        @scope = @scope.flatten.compact.uniq.map(&:to_sym)
      end

      def process_hash(hash)
        @id         = hash[:id]
        @scope      = [hash[:scope]].flatten.compact.map(&:to_sym) 
        @type       = hash[:type].to_sym if hash[:type]
        @resources  = []
        @resources  += hash[:resources].map(&:to_sym) unless hash[:resources].blank?
        hash[:subjects].each { |subject| add_subject(subject) } unless hash[:subjects].blank?
      end

  end
end
