require "active_support"
require "active_support/core_ext"

require 'pry'

require "sanction/version"

module Sanction

  autoload :SearchableArray, 'sanction/searchable_array'
  autoload :Tree,            'sanction/tree'
  autoload :Node,            'sanction/node'
  autoload :Permission,      'sanction/permission'

  module Whitelist
    autoload :Array,  'sanction/whitelist/array'
    autoload :Node,   'sanction/whitelist/node'
  end

  module Blacklist
    autoload :Array,     'sanction/blacklist/array'
    autoload :Node,      'sanction/blacklist/node'
    autoload :NullArray, 'sanction/blacklist/null_array'
    autoload :NullNode,  'sanction/blacklist/null_node'
  end

  extend self

  def build(hash)
    "sanction/#{hash[:mode]}/node".classify.constantize.new(hash)
  end

  def hash
    {
      mode: 'whitelist',
      scope: ['manage', 'read'],
      subjects: [
        {
          id: 6,
          type: 'bookcase',
          scope: []
        }
      ]
    }
  end

  def permission(permission, *predicates)
    Sanction::Permission.new(permission, *predicates)
  end

end
