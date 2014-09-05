require "active_support"
require "active_support/core_ext"

require 'pry'

require 'sanction/searchable_array'
require 'sanction/searchable_array/blacklist'
require 'sanction/searchable_array/whitelist'
require "sanction/version"
require 'sanction/tree'
require 'sanction/node'
require 'sanction/blacklist'
require 'sanction/whitelist'
require 'sanction/permission'

module Sanction

  extend self

  def build(hash)
    "sanction/#{hash[:mode]}".classify.constantize.new(hash)
  end

  def permission(permission, *predicates)
    Sanction::Permission.new(permission, *predicates)
  end

end
