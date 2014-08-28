module Sanction
  class Blacklist < Node

    def permitted?(type, id)
      self[type].blank? || !self[type].map(&:id).include?(id)
    end

  end
end