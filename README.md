# Sanction

Sanction is a permissions manager specifically for managing nested permission sets, with varying scopes or roles. Having found nothing that fit our specific problem domain. The idea is that object relationships are stored as a Hash, and persisted as JSON, and Sanction can then read that permission graph, and return you a true or false for your resource, or scope for that resource.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sanction'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sanction

## What can it give me?

Sanction is designed to be as flexible as possible, allowing various scopes to be applied to specific points in the resource graph, along with specific grant or deny to global resource types at specific levels. With either whitelisting or blacklisting, plus wildcarding for whitelists.

### Object Structure
```ruby
{
  id:        1
  type:      'bookcase'
  mode:      'whitelist',
  scope:     ['manage', 'read'],
  resources: ['shelf'],
  subjects:  [ ... ]
}
```
* __ID__: The ID of the object that this permission applies to, is optional, root nodes will have a nil ID, in a whitelist node, this can be a wildcard("*") character to allow access to all
* __Type__: The Type of object in this graph, again it is optional, root nodes will have a nil type.
* __Mode__: The mode of operation for the subjects and resources arrays:
  * Whitelist:
    * Objects that exist are allowed, others are denied
    * A blank array is an implicit *DENY ALL* children
  * Blacklist:
    * Objects that exist are denied, others are allowed
    * A blank array is an implicit *ALLOW ALL*
* __Scope__: An array of 'actions' that can be performed on the object, this can be anything, 'read', 'write', 'testing' etc.
* __Resources__: Resources are subject to the mode, blacklist is to exclude these resources from being accessed, whitelist being the opposite.
  * Resources allows/denies will always take presedence over objects in the subjects array
* __Subjects__: An array that contains more of these objects, subject to the whitelist/blacklist mode of operation

### Interface

To generate an interactive object graph from storage:
```ruby
perms = Sanction.build(hash)
```

This will return you the root node of the graph, and you can navigate it by using hash accessors, and then call interrogation methods on the returned objects

```ruby
perms[:bookcase][1]                    # => Node in the graph
perms[:bookcase][1].permitted?         # => true/false
perms[:bookcase][1].has_scope?(:read)  # => true/false
perms[:bookcase][1].whitelist?         # => true/false
perms[:bookcase][1].blacklist?         # => true/false
```

You can also get the state of the collection of objects too.

```ruby
perms[:bookcase].allowed_ids          # => Array of allowed ids
perms[:bookcase].denied_ids           # => Array of allowed ids
perms[:bookcase].whitelist?           # => true/false
perms[:bookcase].blacklist?           # => true/false
perms[:bookcase].permitted?           # => true/false
perms[:bookcase].has_scope?(:read)    # => true/false
```

And mutate the state of the graph

```ruby
perms.whitelist?               # => true
perms[:bookcase][1].allow! 
perms[:bookcase][1].permitted? # => true

perms[:bookcase][1].deny!
perms[:bookcase][1].permitted? # => false

perms[:bookcase][1].scope << :testing
perms[:bookcase][1].has_scope? :testing # => true

perms = perms.change_type! :blacklist # => Returns a new root graph, blacklisted at root
perms[:bookcase].whitelist?           # => false

perms[:bookcase][1].change_type! :blacklist # => Changes this to blacklist mode, applies to children
perms[:bookcase][1][:shelf].whitelist?      # => false
```

And of course add/remove objects.

```ruby
perms.add_subject({
  id:   1
  type: 'user'
})

perms.whitelist?             # => true
perms[:user][1].permitted?   # => true


perms[:user][1].unlink
perms[:user][1].permitted?   # => false
```

One caviate is that for nodes that have a deny on a specific resource type, even if you add it in the graph it will still return false, ensure you either remove/add the resource type to the resources array, or ensure that a whitelisted node has a wildcard("*").

The best bit is that the objects don't have to exist in the graph to be queried against, it just relies on the last fragment it could find and applies the rule that was set there.

```ruby
perms.whitelist? # => true
perms[:bookcase][1][shelf][12][book][3].permitted? # => false
```

## Contributing

1. Fork it ( https://github.com/boardiq/sanction/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
