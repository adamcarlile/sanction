module Sanction
  class Blacklist < Node

    def permitted?(type, id)
      self[type].blank? || !self[type].map(&:id).include?(id)
    end

    def whitelist?
      false
    end

    def blacklist?
      true
    end

    def array_class
      SearchableArray::Blacklist
    end

  end
end