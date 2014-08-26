require 'sanction'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

class Bookcase
  attr_accessor :id
end

class Shelf
  attr_accessor :id
end

class Pack
  attr_accessor :id
end


PERMISSIONS = {
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