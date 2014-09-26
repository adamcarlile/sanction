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
    autoload :Array,     'sanction/whitelist/array'
    autoload :Node,      'sanction/whitelist/node'
    autoload :NullArray, 'sanction/whitelist/null_array'
    autoload :NullNode,  'sanction/whitelist/null_node'
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
          id: 1,
          mode: 'blacklist',
          type: 'bookcase',
          scope: [],
          subjects: [
            {
              id: 6,
              type: 'shelf',
              scope: ['manage']
            }
          ]
        },{
          id: 2,
          mode: 'whitelist',
          type: 'bookcase',
          scope: ['read'],
          subjects: [
            {
              id: 7,
              mode: 'blacklist',
              type: 'shelf',
              scope: ['manage', 'read'],
              subjects: [
                {
                  id: 8,
                  type: 'pack'
                }
              ]
            },
            {
              id: 4,
              mode: 'whitelist',
              type: 'shelf',
              subjects: [
                {
                  id: 5,
                  type: 'pack',
                  scope: ['manage', 'read']
                }
              ]
            }
          ]
        }
      ]
    }
  end

  def permission(permission, *predicates)
    Sanction::Permission.new(permission, *predicates)
  end

end
