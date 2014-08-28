# Sanction

Sanction is a permissions manager specifically for managing nested permission sets, with varying scopes or roles. Having found nothing that fit our specific problem domain we wrote this. The idea is that object relationships are stored as a Hash, and persisted as JSON, and Sanction can then read that permission graph, and return you a true or false for your resource, or scope for that resource.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sanction'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sanction

## Sample Hash

The below hash describes a simple object graph, as is in fact the one used in the gems specs. It revolves around the idea of `whitelist` and `blacklist` which apply to the subjects array. For example, the root node is `whitelist` which indicates that only subjects that are `{type: 'bookcase', id: 1} || {type: 'bookcase', id: 2}` are permitted.

### Important
  - Whitelists with no subjects are an implicit *DENY ALL*
  - Blacklists with no subjects are an implicit *ALLOW ALL*
  - Empty scopes defer to the parents scope

```ruby
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
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sanction/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
