module Sanction
  class Whitelist < Node

    def permitted?(type, id)
      self[type].any? && self[type].map(&:id).include?(id)
    end

  end
end