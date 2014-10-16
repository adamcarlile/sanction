require "active_support"
require "active_support/core_ext"
require "sanction/version"

module Sanction

  autoload :AttachedList,    'sanction/attached_list'
  autoload :Tree,            'sanction/tree'
  autoload :Node,            'sanction/node'
  autoload :Permission,      'sanction/permission'

  module Whitelist
    autoload :List,      'sanction/whitelist/list'
    autoload :Node,      'sanction/whitelist/node'
    autoload :NullList,  'sanction/whitelist/null_list'
    autoload :NullNode,  'sanction/whitelist/null_node'
  end

  module Blacklist
    autoload :List,      'sanction/blacklist/list'
    autoload :Node,      'sanction/blacklist/node'
    autoload :NullList,  'sanction/blacklist/null_list'
    autoload :NullNode,  'sanction/blacklist/null_node'
  end

  extend self

  def build(hash)
    "sanction/#{hash[:mode]}/node".classify.constantize.new(hash)
  end

  def permission(permission, *predicates)
    Sanction::Permission.new(permission, *predicates)
  end

end
