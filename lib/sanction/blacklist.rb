module Sanction
  class Blacklist < Node

    def permitted?
      if parent[type].blank? || !parent[type].map(&:id).include?(id)
        true
      else
        false
      end
    end

  end
end