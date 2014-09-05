module Sanction
  class Whitelist < Node

    def permitted?(type, id)
      self[type].any? && self[type].map(&:id).include?(id)
    end

    def whitelist?
      true
    end

    def blacklist?
      false
    end

    def array_class
      SearchableArray::Whitelist
    end

  end
end