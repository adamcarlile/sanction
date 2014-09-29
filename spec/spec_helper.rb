require 'sanction'
require 'awesome_print'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

class Bookcase
  attr_accessor :id

  def initialize(id)
    @id = id
  end
end

class Shelf
  attr_accessor :id

  def initialize(id)
    @id = id
  end
end

class Pack
  attr_accessor :id

  def initialize(id)
    @id = id
  end
end


PERMISSIONS = {
      mode: 'whitelist',
      scope: ['manage', 'read'],
      resources: ['bookcase', 'shelf', 'pack', 'user'],
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