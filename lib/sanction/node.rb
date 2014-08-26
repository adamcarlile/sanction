module Sanction
  class Node
    include Tree

    attr_reader :id, :type

    def initialize(hash, parent=nil)
      @parent = parent
      process_hash(hash)
    end

    def to_hash
      {
        id: @id,
        type: @type,
        mode: mode,
        scope: @scope,
        subjects: subjects.map {|x| x.to_hash}
      }.reject { |k, v| v.blank? }
    end

    def add_subject(hash)
      mode = hash[:mode] || :blacklist
      children << "sanction/#{mode}".classify.constantize.new(hash, self)
    end

    def [](key)
      SearchableArray.new(subjects.select {|x| x.type?(key) })
    end

    def find(type, id)
      walk do |child|
        return child if (child.type?(type) && child.id?(id))
      end
    end

    def has_scope? scope
      @scope.include? scope.to_sym
    end

    def type?(type)
      @type == type.to_sym
    end

    def id?(id)
      @id == id.to_i
    end

    def scope
      @scope.blank? ? parent.scope : @scope
    end

    def mode
      self.class.to_s.demodulize.underscore
    end

    def children?
      children.any?
    end

    alias :subjects :children

    private

      def process_hash(hash)
        @id     = hash[:id]
        @scope  = hash[:scope].map(&:to_sym) if hash[:scope]
        @type   = hash[:type].to_sym if hash[:type]
        hash[:subjects].each { |subject| add_subject(subject) } unless hash[:subjects].blank?
      end

  end
end