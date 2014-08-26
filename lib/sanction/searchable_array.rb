module Sanction
  class SearchableArray < Array

    def [](index)
      entries.detect {|x| x.id == index}
    end

  end
end